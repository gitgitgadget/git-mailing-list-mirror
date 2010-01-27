From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Wed, 27 Jan 2010 12:18:35 +0100
Message-ID: <1a6be5fa1001270318h4ac8ac3bnaba48787a5b3efa6@mail.gmail.com>
References: <alpine.LNX.2.00.1001251628431.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 27 12:19:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Na5v1-00010K-Gw
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 12:18:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754465Ab0A0LSj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jan 2010 06:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319Ab0A0LSi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 06:18:38 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:53176 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753104Ab0A0LSh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jan 2010 06:18:37 -0500
Received: by fxm20 with SMTP id 20so1430045fxm.21
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 03:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nDLapykuIV8U4R/1ehPe2WROfvrxCT/tOYwcsWQtZkY=;
        b=QVv64hyVmgRsXAN7xzua7mZ3pbxbG3vxbICKrozVko53zimUsAtl9AQl7/d1d5PZRr
         yl5Q7Ka92ewzdFxPkB6I+o7Chv20ZUUKc0nbzO/HI3lkpIahTJzRxFmJ8m5Nkt7ckG47
         N5PVg7S4f3v5six5o0HhoNyXH81U+3UwWbPR8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q9B/mR30k3KADhFkgubVwsYFlI66vLC1zaq25RBLPdcoJqLtxDpkm4y4UKbaxCeeMk
         S1WG3p0PiqwvCioF2hYypz1H1jsNVhDlSdRFtuXvyglnS5ngXY/o7L3dBMVMaFAYwkS4
         +BQlNKhUuNYADqcsTRZ6fdGfA6w2+VsuG74QU=
Received: by 10.239.187.204 with SMTP id m12mr992964hbh.160.1264591115524; 
	Wed, 27 Jan 2010 03:18:35 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1001251628431.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138127>

On Mon, Jan 25, 2010 at 10:35 PM, Daniel Barkalow <barkalow@iabervon.or=
g> wrote:
> This is probably not particularly appropriate for mainline
> application, and is somewhat buggy, not extensively tested, and
> incomplete. The push support is also currently based on a transport h=
elper
> export design that isn't upstream and I don't like any more; a better
> design is probably to have the core send an "export" command and then=
 a
> gfi stream, but I haven't worked on this.
>
> It has two implementations of the interaction with the Perforce
> server: one that uses the command-line client (and therefore makes a
> ton of separate connections to the server) and one that uses the
> (closed source, vaguely licensed) C++ API. The former does not suppor=
t
> everything used in push/submit correctly at this point.
>
> It also adds support to the Makefile for building C++ object files an=
d
> linking with a C++ linker. It should be easy to omit entirely for
> builds that don't use p4, and it's at least somewhat out of the way.
>
> The biggest flaw currently is that it doesn't save its analysis of th=
e
> structure of the history, and doesn't have a way to push it out of me=
mory,
> so a long or complex history will run you out of memory or will take =
a
> long time to do an incremental fetch.
>
> Fetch features:
>
> =C2=A0- following integrations (with some guessing)
> =C2=A0- finding other branches of a codeline
>
> Push features (only with the C++ API):
>
> =C2=A0- works if you don't do anything at all complicated
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
<snip>

Hi, and thank you for posting this.

I tried applying it to current master, and got it to compile using the
p4 c++ api.

However, I'm having trouble getting it to run. This is most certainly
my own fault, and I'm guessing it has to do with my .git/config file
setup.

I tried doing 'git init', and making a .git/config file like so:
------------
[core]
        repositoryformatversion =3D 0
        filemode =3D true
        bare =3D false
        logallrefupdates =3D true

[vcs-p4]
        port =3D perforce.mycompany.com:1666
        client =3D toral

[remote "origin"]
        vcs =3D p4
        codeline =3D //depot/path/to/my/existing/test/project
------------
Then, I did 'git fetch', and got a seg fault. I got around it by
commenting out a line:

diff --git a/transport.c b/transport.c
index 7714fdb..5b404f7 100644
--- a/transport.c
+++ b/transport.c
@@ -924,7 +924,7 @@ struct transport *transport_get(struct remote
*remote, const char *url)
        ret->url =3D url;

        /* In case previous URL had helper forced, reset it. */
-       remote->foreign_vcs =3D NULL;
+/*     remote->foreign_vcs =3D NULL;*/

        /* maybe it is a foreign URL? */
        if (url) {

-------------
So - now I get this:

$ GIT_TRANSPORT_HELPER_DEBUG=3D1 git fetch
Debug: Remote helper: -> capabilities
Debug: Remote helper: Waiting...
Debug: Remote helper: <- import
Debug: Got cap import
Debug: Remote helper: Waiting...
Debug: Remote helper: <- export
Debug: Got cap export
Debug: Remote helper: Waiting...
Debug: Remote helper: <-
Debug: Capabilities complete.
Debug: Remote helper: Waiting...
Debug: Remote helper: <- ? refs/p4/depot/path/to/my/existing/test/proje=
ct
Debug: Remote helper: Waiting...
Debug: Remote helper: <- ? refs/p4/depot/path/to/my/existing/test/proje=
ct
Debug: Remote helper: Waiting...
Debug: Remote helper: <-
Debug: Read ref listing.
fatal: Couldn't find remote ref HEAD
-------------

I also tried setting vcs-p4.findbranches to 'true'. The only
difference in the output, is that the "<- ? refs/p4/..." line is just
output once.

So if anyone has a clue for me, I shall, well, cease to be clueless.

-Tor Arvid-

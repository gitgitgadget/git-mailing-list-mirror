From: "=?ISO-8859-1?Q?Marc-Andr=E9_Lureau?=" <marcandre.lureau@gmail.com>
Subject: Re: [PATCH] git-cvsimport: fix initial checkout
Date: Fri, 14 Mar 2008 01:04:13 +0200
Message-ID: <e29894ca0803131604qa61adfbo22ff75d076feb899@mail.gmail.com>
References: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
	 <47D9A836.9010601@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Martin Langhoff" <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:05:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZwTp-0006nW-Bw
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 00:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbYCMXET convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 19:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbYCMXES
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 19:04:18 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:64674 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbYCMXES convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2008 19:04:18 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3965444wxd.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 16:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8+LoaIzgg2G7vlDYKrvkv2XZGswtgUj1vwdft3huwZo=;
        b=uCsf+/XA1WKrI4tjC/iswOEUKCoGWLeQuJhFRCHzt+Q9AO9D519zhp7xP9+xK14umwdpLBzaXQXQIR75WDmzxTjdb8ZiXVGaRY89O3R+owO7l0ZeWSmQW5jlUTW6KF9PNWDEyAAXgRuvPHtZU4qejZZrszSxLKuJIw5IhLwJ+IM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mi3gKdfytjptntjzQpChThGrR4pFCXj6wpdSd04m9SIH22hzu+e86hC72GEfuUWiPOJdYpivbpVQQKYf+WQmZRNKKRS2jTginVLUg8Xkaj2LuvO78wHC9RiEcXP2Vrj/CvYXRgQBXMuqYLGgBBcMBOxfh2UPTADbUWeLbykBz78=
Received: by 10.115.18.1 with SMTP id v1mr10568153wai.81.1205449453231;
        Thu, 13 Mar 2008 16:04:13 -0700 (PDT)
Received: by 10.114.60.4 with HTTP; Thu, 13 Mar 2008 16:04:13 -0700 (PDT)
In-Reply-To: <47D9A836.9010601@catalyst.net.nz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77144>

Hi

On Fri, Mar 14, 2008 at 12:18 AM, Martin Langhoff
<martin@catalyst.net.nz> wrote:
> Marc-Andre Lureau wrote:
>  > git-symbolic-ref HEAD returns master reference, even if the file d=
oes
>  > not exists. That prevents the initial checkout and fails in
>  > git-rev-parse.
>
>  But you are patching the block that gets triggered on subsequent
>  imports, this code does not deal with "initial checkout" unless
>  something else is wrong. The line right above the open() is an else =
that
>  has the block that matters.
>

Yeah, it failed in the middle of a ~4h import, I did not restart it.

git-cvsimport -r cvs -p b,HEAD -k -m -a -v -d
:pserver:anoncvs@anoncvs.freedesktop.org:/cvs/gstreamer -C
gst-plugins-good gst-plugins-good

This is a quite problematic CVS, btw. (missing patches/files in the
end, branch merge fail ... see my previous patch)

>  > The patch checks the existence of the reference file
>  > before assuming an original branch exists. There might be better
>  > solutions than checking file existence.
>
>  There are indeed. If we need this patch -- then you can call git
>  ref-parse right to see if you get a sha1.

Ok, which one is prefered? ref-parse I guess? I am mostly ignorant of
all the plumbing stuff.

>  > -     unless ($last_branch) {
>  > +     if (-f "$git_dir/$last_branch") {
>
>  Note that the file won't exist there in any modern git. It will be i=
n
>  $git_dir/refs/heads/$last_branch. Did you test this patch?
>

Crap. The patch indeed worked, because the file did not exist. The
second time it also worked:

skip patchset 5825: 1205277122 before 1205418644
skip patchset 5826: 1205418644 before 1205418644
DONE.
Already up-to-date.
*** Building gst-plugins-good *** [1/145]
make -j2


Result is here: http://git.infradead.org/users/elmarco/gst-plugins-good=
=2Egit

Thanks for the review!!

--=20
Marc-Andr=E9 Lureau

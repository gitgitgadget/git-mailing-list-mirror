From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] reflog documentation: -n is an alias for --dry-run
Date: Sun, 13 Sep 2009 15:05:04 +0200
Message-ID: <40aa078e0909130605s5b445fdclb22147ce070d0581@mail.gmail.com>
References: <1252813314-14408-1-git-send-email-nelhage@mit.edu>
	 <20090913094032.GC14438@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nelson Elhage <nelhage@mit.edu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 15:05:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmolZ-0002Rs-Hq
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 15:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001AbZIMNFE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Sep 2009 09:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752888AbZIMNFD
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 09:05:03 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:46736 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZIMNFD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Sep 2009 09:05:03 -0400
Received: by bwz19 with SMTP id 19so1582939bwz.37
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3u6DoQmTajVby4X4G4VOkmfioCQAHVKRkot5KOgz5GU=;
        b=EJ5qqHzbYChHbEdA6GsaWvVRIAh0ZKFWpfYovy9fFQSyYInqhnS8d9y4mhDD8O+BYl
         rr12WhCw8aSTQ5izqdx0ddbT0izKXTqbZz1ZeOEMERdhuk0l193Uez5Fnyu6KoxAx+wq
         4/7XI3ghxsr7GU4/INiPLma7+rPppRnYUpx7c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mLWhsT4TTW8V/Ew5qrLcDOSMHboUvqM3r3gn5DNz8mz1xO7/Ok6sDeO4tdToi14fCE
         SXOUF4m3Y9yXWuh66Iq2NWIa/UC05RqFnyclhduiCWPIznU99V5BHYhYrAupCuOUgDvG
         Rg7DD6FfPXYd6pNSw6W9wNeHnd34W6BtbbPRk=
Received: by 10.204.15.7 with SMTP id i7mr4057784bka.126.1252847104696; Sun, 
	13 Sep 2009 06:05:04 -0700 (PDT)
In-Reply-To: <20090913094032.GC14438@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128358>

On Sun, Sep 13, 2009 at 11:40 AM, Jeff King <peff@peff.net> wrote:
>> =A0static const char reflog_expire_usage[] =3D
>> -"git reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--=
expire=3D<time>] [--expire-unreachable=3D<time>] [--all] <refs>...";
>> +"git reflog (show|expire) [--verbose] [-n | --dry-run] [--stale-fix=
] [--expire=3D<time>] [--expire-unreachable=3D<time>] [--all] <refs>...=
";
>
> Really? I think "git reflog show -n" is not about dry-run at all...

Indeed. However, the reflog expire uses -n as an alias for --dry-run,
according to lines 548-549 of my builtin-reflog.c (ddfdf5a):

		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
			cb.dry_run =3D 1;

=2E..and this usage-string is only output from cmd_reflog_expire, so th=
e
correct solution would IMO be to simply remove show from the
usage-string:

-"git reflog (show|expire) [--verbose] [-n | --dry-run] [--stale-fix]
[--expire=3D<time>] [--expire-unreachable=3D<time>] [--all] <refs>...";
+"git reflog expire [--verbose] [-n | --dry-run] [--stale-fix]
[--expire=3D<time>] [--expire-unreachable=3D<time>] [--all] <refs>...";

This issue ("reflog expire" incorrectly documenting "reflog show") was
present before this patch, though. At least the option "--stale-fix"
appears not to be valid for "reflog show".

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656

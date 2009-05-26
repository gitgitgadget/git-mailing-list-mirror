From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC] Convert ce_path_match() use to match_pathspec()
Date: Tue, 26 May 2009 21:04:35 +1000
Message-ID: <fcaeb9bf0905260404h3eb35355p4fec33bc1912ce9b@mail.gmail.com>
References: <1243240924-5981-1-git-send-email-pclouds@gmail.com> 
	<7voctgvnic.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 13:05:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8uSs-00084q-2W
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 13:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbZEZLEz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 May 2009 07:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbZEZLEz
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 07:04:55 -0400
Received: from an-out-0708.google.com ([209.85.132.249]:25073 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbZEZLEy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 May 2009 07:04:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so8352653and.1
        for <git@vger.kernel.org>; Tue, 26 May 2009 04:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=jEter3Mo4OFCpsa7PrNFnpqXRV0in/mouZX4p5fp7jI=;
        b=ayxyjUqIK4yRqBK8Putl+4LapKCTUDLh/pIqrrIAq0gLJWUmHmRl0iGZI3PWNesd5m
         GbcyXCY+2Ms+mW0ZY9ZIG+gKMcr0A+PyrHVJpyta6lS33eJfyisWbMK9eD2lADbxd/an
         kCxGJ2fQ7xWPX+SHipmFIUcVSvMdzYMKrEak4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=OYcbwni7MFQq1HbHbpsgCt3pXEf/3UJbIebG1tDqhEbJRsO8ubx9vBdAfNHwXsyFqS
         fEYLVAfBoTRv3b5V5p1d5keOXRC3O1dIDKYI2B+6c0CwDTy7rU1/gWmcWgH6RF4p7DzH
         9YGi927/Q3OpZyOBrHUyGVul6onkQ9lY+UsEM=
Received: by 10.100.143.9 with SMTP id q9mr14004662and.145.1243335895697; Tue, 
	26 May 2009 04:04:55 -0700 (PDT)
In-Reply-To: <7voctgvnic.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120001>

2009/5/26 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> For some reasons diff code did not get converted to use
>> match_pathspec(). So diff commands do not understand wildcards.
>
> ce_path_match() is not just about diffs; there may be places that do =
not
> expect pathspecs to match cruft with globs. =C2=A0Have you checked al=
l the
> callsites and they are Ok with globbing?

I'm pretty sure except preload-index. I have checked again, all
read_cache_preload() callsites seem to prefer files and leading path
over globbing.

> I think using glob in diff-files should be Ok, but that would make it
> inconsistent with diff-tree (and possibly diff-index but I didn't che=
ck).
> The correct operation of diff-tree (and path pruning in "git log" fam=
ily)
> heavily relies on an early-exit optimization not to recurse into a
> directory when we can detect that none of the paths in that directory=
 will
> ever match any of the given pathspecs, and this is done based on the
> non-globbing (iow "leading path") semantics; you need to be extra car=
eful
> about this.

Now I know the reason. Thanks.
--=20
Duy

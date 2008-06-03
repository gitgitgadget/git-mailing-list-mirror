From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 15:12:20 +0200
Message-ID: <200806031512.20729.jnareb@gmail.com>
References: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com> <200806031445.23002.jnareb@gmail.com> <b77c1dce0806030600x520d35edxbe6e732ce6cc4ad6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>
To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 15:13:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3WKG-0005Rt-FH
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 15:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754242AbYFCNM1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Jun 2008 09:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbYFCNM1
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 09:12:27 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:33960 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbYFCNM0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 09:12:26 -0400
Received: by nf-out-0910.google.com with SMTP id d3so584982nfc.21
        for <git@vger.kernel.org>; Tue, 03 Jun 2008 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=bcjHAuR1/T3Yeoxo/+NjdBnfR3PfsuWAT8wsx38ILUo=;
        b=w10hnABsN+YdrzxoSDGDN3glxlbOKjp7d58X0OTQfbilU6HZ8EL04KAVOSahPszgEbbbb3cVrJWhvpnUqbaufsi2xz4/cjSRhXUzCp6OPKKV4/nUhA93IBhPbOlKJu42qgpGmsNBvedLasBMGSlQrPBiMFabwhP4dOWOmOPzCVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ETAIHvpHjCQBRqWQoH7T8arQ7prPXYR97rXg6db2f4DH0YCHfa4lqTV6lo1mw3kaIxsTqo4LHTw8zaIBYsS3g3HesD21ZqccEh6G0CSZ1+Cvh5eEQNDDfcg0DQRK6RwYWe9ARxvbrvQuvpA0/OpSnQCj4rqahjkTo0wsE0jPBIQ=
Received: by 10.86.68.20 with SMTP id q20mr1251769fga.2.1212498744755;
        Tue, 03 Jun 2008 06:12:24 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.251.199])
        by mx.google.com with ESMTPS id d4sm5282123fga.8.2008.06.03.06.12.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Jun 2008 06:12:23 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <b77c1dce0806030600x520d35edxbe6e732ce6cc4ad6@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83652>

Dnia wtorek 3. czerwca 2008 15:00, Rafael Garcia-Suarez napisa=B3:
> 2008/6/3 Jakub Narebski <jnareb@gmail.com>:
>> On Tue, 3 June 2008, Rafael Garcia-Suarez wrote:

>> I was thinking about extending git-blame porcelain format (and also
>> incremental format, of course) by 'parents' (and perhaps
>> 'original-parents') header...
>=20
> OK, I see. That would be nice. Also: currently taking "$full_rev^"
> directs the user to the parent commit, but it would be more
> user-friendly to point at the previous commit where the selected file
> was modified instead.

That's what I meant by distinguishing between 'parents' and
'original-parents' (or 'rewritten-parents' and 'parents'): first are
rewritten parents in history limited to specified file (with the
addition of code movements and copying across files/filenames),
second are original parents of a commit.

=46or gitweb we would use the first set (I wonder what to do in the cas=
e
of merge commit, i.e. more than one parent).
=20
>>> We could however cache the results of git-rev-parse, since the same
>>> rev is likely to appear many times in the list.
>>
>> ...but starting with cache of git-rev-parse results, or optionally
>> allowing extended sha-1 syntax (including <hash>^) in hash* CGI
>> parameters in gitweb would be a good idea.
>>
>> But as I wrote, I'm fine with the patch as it is now.
>=20
> I've sent a new version (take 2) with caching. And comments, as Lea
> suggested :)=20
=20
Nice. Thanks a lot.

Ack, FWIW.
--=20
Jakub Narebski
Poland

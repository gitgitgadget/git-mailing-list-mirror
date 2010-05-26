From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 2/3] t7502-commit: add summary output tests for empty and 
	merge commits
Date: Wed, 26 May 2010 13:19:42 +0800
Message-ID: <AANLkTikuukaZNVY8ikn3v1zdzGHUDLBC55fGih7Dgs7L@mail.gmail.com>
References: <1274694452-4200-1-git-send-email-rctay89@gmail.com>
	 <1274694452-4200-2-git-send-email-rctay89@gmail.com>
	 <1274694452-4200-3-git-send-email-rctay89@gmail.com>
	 <7vvdabp7xa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 26 07:20:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH91x-0003YD-5t
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 07:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933720Ab0EZFTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 01:19:44 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42253 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887Ab0EZFTn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 01:19:43 -0400
Received: by gyg13 with SMTP id 13so2545424gyg.19
        for <git@vger.kernel.org>; Tue, 25 May 2010 22:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GZ1EKeCm123ctJSRSpI/zFuyfgfPQemi+X3fqQlKdu8=;
        b=dNgWykyhcjLthrAxORDQUzCqvAt6zXvhafK6XkkMK5U4c/MP9exNiQjR8VDMKVWh2I
         ER0Yz/ufgwoS75RO5CUBolFoVRQd5J8FspWcO4zPP+CSo4O0rnCNvclaL4SXcWJm8pet
         eg6hJfMp0SKjJW5IpBnXZvwmDmqEoSJE7Zb8w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NyH0M9Axzj9zIjiXxWDmSAcLh963Yn6CvyQ3aHkKyZvPedKxT+1SnhK/1zTI/ttl61
         7dVVLaO8+sVEvZdW/6HmhdQjySWTJFhxHiFa9qALc0kQd95o1fVEL4J7WrmDLnwRqd4d
         WlfkL0yfP1wn3xhjuaxydowGQRKeRyl+GW9ms=
Received: by 10.231.120.37 with SMTP id b37mr5984389ibr.81.1274851182533; Tue, 
	25 May 2010 22:19:42 -0700 (PDT)
Received: by 10.231.33.12 with HTTP; Tue, 25 May 2010 22:19:42 -0700 (PDT)
In-Reply-To: <7vvdabp7xa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147743>

Hi,

On Wed, May 26, 2010 at 1:07 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> After c197702 (pretty: Respect --abbrev option), non-abbreviated has=
hes
>> began to appear, leading to failures for these tests.
>>
>> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
>> ---
>> =A0t/t7502-commit.sh | =A0 29 +++++++++++++++++++++++++++--
>> =A01 files changed, 27 insertions(+), 2 deletions(-)
>>
>> diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
>> index 589e8e6..8a4a277 100755
>> --- a/t/t7502-commit.sh
>> +++ b/t/t7502-commit.sh
>> @@ -4,10 +4,10 @@ test_description=3D'git commit porcelain-ish'
>>
>> =A0. ./test-lib.sh
>>
>> -# Arguments: [<prefix] [<commit message>]
>> +# Arguments: [<prefix] [<commit message>] [<commit options>]
>> =A0check_summary_oneline() {
>> =A0 =A0 =A0 test_tick &&
>> - =A0 =A0 git commit -m "$2" | head -1 > act &&
>> + =A0 =A0 echo "$3" | xargs git commit -m "$2" | head -1 > act &&
>
> Why do you have to fork xargs? =A0Wouldn't/shouldn't
>
> =A0 =A0git commit ${3+"$3"} -m "$2"
>
> work?

It would. Blame it on my poor shell-fu. :)

--=20
Cheers,
Ray Chuan

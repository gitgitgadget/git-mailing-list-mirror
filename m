From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote HEADs
Date: Sat, 14 Feb 2009 13:35:03 -0500
Message-ID: <76718490902141035o5430707ck47cd72d9efe87318@mail.gmail.com>
References: <20090214034345.GB24545@coredump.intra.peff.net>
	 <1234607430-5403-1-git-send-email-jaysoffian@gmail.com>
	 <20090214175420.GA3457@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 19:36:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYPNV-0003mw-4Z
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 19:36:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751795AbZBNSfG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 13:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbZBNSfG
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 13:35:06 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:55589 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbZBNSfE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 13:35:04 -0500
Received: by rv-out-0506.google.com with SMTP id g37so1055506rvb.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 10:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NHLbsXNqjWL+dW8wyakn9tSvf6ZhzscCF4Yltx5GEe8=;
        b=mIIvVYhiUcVgvWTvtickvtB/84WMPq0ZuJRxEvCqjpHZoXDfgOEgz0norPhTy8cafd
         pZwHEck8+64it5s0jxO6liig0GxCOHLoTO3YntRWqcI41n3ZLxVu1QsyZr6zf3hJO3H9
         VKuc4voxxyTqgmsnBg4sPL4XWqZoangDPuuak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=buI6E6sYhA4ofUq2sKuSc8hMHm9GjE7uQihtvi3s3DUq/mhQGEy9rdzYQKa+AJCpFZ
         cdw3cs42WNa7jU1AdVplExhiUROaqXGJQ7TrjcaQ8bHw9X69nnkpwZq+XZR78m9eA2rd
         dgti+wJMRdTnJvdKOnz8VnXxBx98Wab9GJUQM=
Received: by 10.141.209.6 with SMTP id l6mr1774200rvq.192.1234636503496; Sat, 
	14 Feb 2009 10:35:03 -0800 (PST)
In-Reply-To: <20090214175420.GA3457@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109889>

On Sat, Feb 14, 2009 at 12:54 PM, Jeff King <peff@peff.net> wrote:
>> +             if (opt_a)
>> +                     printf("%s/HEAD set to %s\n", argv[0], head_name);
>
> This was a surprise based on reading the commit message, but I think it
> is a sensible enhancement.

It seemed that when doing something "--automatically" it might be nice
to tell the user what we just did, but I'm confused why this was a
surprise.

>> +cat > test/expect <<EOF
>> +origin/HEAD set to master
>> +EOF
>> +
>> +test_expect_success 'set-head --auto' '
>> +     (cd test &&
>> +      git remote set-head --auto origin > output &&
>> +      git symbolic-ref refs/remotes/origin/HEAD &&
>> +     test_cmp expect output)
>> +'
>
> I had to read this test a few times to convince myself it was right,
> since you throw away the output of symbolic-ref. I think it makes more
> sense to just test the post-command state, which is what you actually
> care about (and then you are also not dependent on the human-readable
> output of "remote set-head"). I.e.:
>
> cat > test/expect <<EOF
> refs/remotes/origin/master
> EOF
>
> test_expect_success 'set-head --auto' '
>        (cd test &&
>         git remote set-head --auto origin &&
>         git symbolic-ref refs/remotes/origin/HEAD > output &&
>        test_cmp expect output)
> '

Right.

j.

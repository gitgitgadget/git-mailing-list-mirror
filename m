From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCHv1 3/3] git-p4: fixing --changes-block-size handling
Date: Sun, 07 Jun 2015 18:06:13 +0100
Message-ID: <55747A05.3070704@diamand.org>
References: <1433672505-11940-1-git-send-email-luke@diamand.org>	<1433672505-11940-4-git-send-email-luke@diamand.org> <CALM2SnbVY1baAONo3o2gb2NS+rDSsyhkPffP5EJZKU1MDA7q9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lex Spoon <lex@lexspoon.org>
X-From: git-owner@vger.kernel.org Sun Jun 07 19:07:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1e2I-0008M8-JJ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 19:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbbFGRG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 13:06:58 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:35727 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbbFGRG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 13:06:57 -0400
Received: by wgme6 with SMTP id e6so86873536wgm.2
        for <git@vger.kernel.org>; Sun, 07 Jun 2015 10:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=GD+jGNcsq+w9AK9+rZ+Zac936ZW1cbQtAfypEDvsE8o=;
        b=HYuSSb8VPdBeGF+OyUZRk/Qmx1pwqcN/C4UujNXfGCzI2zL8An8TM/BSnuc2KeEaX2
         iAUXKcUW+FisXM/kZLNxP2EARJ3ntV9ooG2MyWK5kEW3R/VFa6ToIPhzmZyXP5Wo+75p
         ktqXVoNr8xLxpNeQ0+BjEds977iAgIRaGfKNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=GD+jGNcsq+w9AK9+rZ+Zac936ZW1cbQtAfypEDvsE8o=;
        b=D215SYcc3CT9Zpxt6wgTF819xExzM1AwCMYzEHGwODGdpANUWl8Dup6n2Do/vkHA/7
         tWizaeGzeoefAv2uEy4d5DvpJWuI9QBUsYK2EjvCpuk66ka68jWzzKrRVSxeKWfVQub3
         6QPI+bVIjSPUbUxJuuXOSjhIdMu1XOevhfkOhmikTLztlYAXNIGzNRtjg+alhACDs4mt
         oI/j9x7zOb+Co+HuYV+osHqsX5JD1WF/tQonGDAqZqgDZ/jUXvaVWIiauLecZnLQUIX+
         2/5dcArocgnOXfEhsKOc6juJdzrn827Nthiqe9Q81DU7gfpeIBR7uMSLggTowMHOdVbF
         N+Yg==
X-Gm-Message-State: ALoCoQlLLkeRm9TmBCZEaCP497DTS8W4eju31Hjg4/kbOn4clnb4N0yPqu8VI0jJcPyVv0b4aICs
X-Received: by 10.180.205.168 with SMTP id lh8mr12673383wic.95.1433696815794;
        Sun, 07 Jun 2015 10:06:55 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id n6sm4390340wic.16.2015.06.07.10.06.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Jun 2015 10:06:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CALM2SnbVY1baAONo3o2gb2NS+rDSsyhkPffP5EJZKU1MDA7q9w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270976>

On 07/06/15 17:33, Lex Spoon wrote:
> The implementation looks fine, especially given the test cases that
> back it up. I am only curious why the block size is set to a default
> of None. To put it as contcretely as possible: is there any expected
> configuration where None would work but 500 would not? We know there
> are many cases of the other way around, and those cases are going to
> send users to StackOverflow to find the right workaround.

I think it was just caution: it's pretty easy to make it fall back to 
the old non-batched scheme, so if it turns out that there *is* a 
problem, fewer people will hit the problem and we're less likely to have 
a paper-bag release.

>
> Dropping the option would also simplify the code in several places.
> The complex logic around get_another_block could be removed, and
> instead there could be a loop from start to mostRecentCommit by
> block_size. Several places that check "if not block_size" could just
> choose the other branch.

Fair point. I'll give it a go and see what happens.

(Plus 500 is a very unnatural number, chosen just because we still place 
some kind of significance on a chance evolutionary accident that gave 
our ape ancestors 5 digits on each hand :-)

Luke

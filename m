From: Elliot Wolk <elliot.wolk@gmail.com>
Subject: Re: move detection doesnt take filename into account
Date: Tue, 01 Jul 2014 11:05:46 -0400
Message-ID: <53B2CE4A.9060509@gmail.com>
References: <53B105DA.30004@gmail.com>	<287177519.16421.1404206204124.JavaMail.zimbra@dewire.com> <xmqqtx71xh27.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 17:05:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X1zd2-0000Al-Ka
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 17:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757677AbaGAPFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 11:05:48 -0400
Received: from mail-qa0-f42.google.com ([209.85.216.42]:61238 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081AbaGAPFs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 11:05:48 -0400
Received: by mail-qa0-f42.google.com with SMTP id dc16so7908543qab.29
        for <git@vger.kernel.org>; Tue, 01 Jul 2014 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=/O05Ei1yxzVboLC4k+ij8jwu8VotQ9OefeNn2Zp9pL8=;
        b=c1Bxbu4ZAVImj8UZPfGjqFLJihf1neQcGtMuExVLcGOR7ePzxwcmzSmdAVxs9wweyn
         3qVsDOqJxW4qVLt0Y722CUd8lOHf8ixXkwF2XEYmMw127iVzG68SqG6tJjXW7yISMxGB
         q5yeeUASDAKQyeH0PkHTWvDgVQJc+FNVTgi311GhEmWcOe0+zX0t8818hMVb86R8rAW7
         CMHCxCtn3BTKYYyBe0Wx0V+tY19xd3eA9INOMjwA1/Jtq68kq6369ViCvBeh4bT7A6Jk
         lY+Li75Y9VjnkAnILOoI41Y8Ol6iYQuB2URyPIdQca+3xOv1Q4NlsnhbtbmNHQ2LCAmT
         ipxQ==
X-Received: by 10.224.13.4 with SMTP id z4mr39592036qaz.51.1404227147137;
        Tue, 01 Jul 2014 08:05:47 -0700 (PDT)
Received: from [192.168.11.50] ([98.113.246.12])
        by mx.google.com with ESMTPSA id p67sm8886733qgd.34.2014.07.01.08.05.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jul 2014 08:05:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:30.0) Gecko/20100101 Icedove/30.0
In-Reply-To: <xmqqtx71xh27.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252721>

thanks for the info!
then i suppose my bug is a petition to have name similarity instead use 
a different statistical matching algorithm.

On 07/01/2014 10:57 AM, Junio C Hamano wrote:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
>
>> I think it does, but based on filename suffix. E.g. here is a rename of
>> three empty files with a suffix.
>>
>>   3 files changed, 0 insertions(+), 0 deletions(-)
>>   rename 1.a => 2.a (100%)
>>   rename 1.b => 2.b (100%)
>>   rename 1.c => 2.c (100%)
> This is not more than a chance.
>
> We tie-break rename source candidates that have the same content
> similarity score to a rename destination using "name similarity",
> whose implementation has been diffcore-rename.c::basename_same(),
> which scores 1 if `basename $src` and `basename $dst` are the same
> and 0 otherwise, i.e. from 1.a to a/1.a is judged to be a better
> rename than from 1.a to a/2.a but otherwise there is nothing that
> favors rename from 1.a to 2.a over 1.a to 2.b.

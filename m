From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v5 3/7] change `git_config()` return value to void
Date: Thu, 31 Jul 2014 17:22:34 +0530
Message-ID: <53DA2E02.4000408@gmail.com>
References: <1406799857-28048-1-git-send-email-tanayabh@gmail.com>	<1406799857-28048-4-git-send-email-tanayabh@gmail.com> <vpqoaw5epsa.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 31 13:52:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCoui-0007FB-GT
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jul 2014 13:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750894AbaGaLws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2014 07:52:48 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47396 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbaGaLwr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2014 07:52:47 -0400
Received: by mail-pd0-f172.google.com with SMTP id ft15so3364691pdb.3
        for <git@vger.kernel.org>; Thu, 31 Jul 2014 04:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=v8rxEHepU9mS8yQvcBeZHMfYfZs9JTSUA8vfITbpw0A=;
        b=CIqdqftRC5zKB3EixR40MPOzMjrG611SkRvQzeSzuzutdcvGJ+fV1AC5Bap4y8BnqC
         U0SQM7qlFD4yWsS+fKQ8aFlQUxeKj9rjtKEQf1IA9LYIzwinsKzBT2JnAQZHCVCqrNFu
         o4PGN264NXfnNyEyDtoZH9e9Wsmq1t9mdJ4JxJwAwh4d+LR79Lp1DbbD/yw/qxDV/txY
         57K38IigHNo/zPitUP+vK3E1ij1b/89fbkmvV6lBXZWszaxBVrgWZGMqO3RNUwg/GBOX
         o4L4shvktWLlaEolurmWqZMr4WPXsv3WSeMqRHwkMs+RtABW3NWxHbiDs5X1pOef9Jmo
         lXVg==
X-Received: by 10.68.87.225 with SMTP id bb1mr3654542pbb.89.1406807566674;
        Thu, 31 Jul 2014 04:52:46 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.255.53])
        by mx.google.com with ESMTPSA id st5sm5298184pbc.68.2014.07.31.04.52.34
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 31 Jul 2014 04:52:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <vpqoaw5epsa.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254558>



On 7/31/2014 4:52 PM, Matthieu Moy wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
> 
>> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> 
> I think I deserve a bit of credit here ;-).
>

Yes, but to show credit would I have to write "from you" or
"signed-off-by"? :)

>>  {
>> -	return git_config_with_options(fn, data, NULL, 1);
>> +	if (git_config_with_options(fn, data, NULL, 1) < 0)
>> +		/*
>> +		 * git_config_with_options() normally returns only
>> +		 * positive values, as most errors are fatal, and
>> +		 * non-fatal potential errors are guarded by "if"
>> +		 * statements that are entered only when no error is
>> +		 * possible.
>> +		 *
>> +		 * If we ever encounter a non-fatal error, it means
>> +		 * something went really wrong and we should stop
>> +		 * immediately.
>> +		 */
>> +		die("Unknown error occured while reading the configuration files");
>>  }
> 
> My bad, but this should be die(_("..."));, so that the message can be
> translated. Not really serious since it's not really meant to be seen by
> the user, though.
>

Noted. Though there are not many cases till I have read where error messages are marked
for translation.

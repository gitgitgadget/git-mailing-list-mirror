From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Fri, 25 Jul 2014 08:46:10 +0530
Message-ID: <53D1CBFA.3020107@gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>	<xmqqtx67bt78.fsf@gitster.dls.corp.google.com>	<vpqlhrjqmyw.fsf@anie.imag.fr>	<xmqqiommadl0.fsf@gitster.dls.corp.google.com>	<53D15188.2010209@gmail.com> <vpqegxa386m.fsf@anie.imag.fr>	<xmqqppgu8sxz.fsf@gitster.dls.corp.google.com>	<53D15EB4.1050303@gmail.com> <xmqqlhri8rdb.fsf@gitster.dls.corp.google.com> <53D17919.4020702@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 05:16:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAVzY-0007AD-FH
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 05:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbaGYDQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 23:16:16 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:45199 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbaGYDQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 23:16:16 -0400
Received: by mail-pa0-f47.google.com with SMTP id kx10so5198980pab.20
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 20:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=5NMjMVyxkYZoLlDq3sMCGwNgL7iq6ik8UwP0ymy9pqA=;
        b=tflL2zSrKJaSgVWwE900Qf4zUAdYXR6sDTooUWcEf0j4/xLbGlvhQuzes0vER7HPe/
         0XaS/iln6kl8/KDnFwgwa1G7e27g9vMd53U/eNu0AqeJOqOcteafw6EzYfFGaEd3T6UY
         queLmsTxzgb5RAsV7xDRTLlasRXo5KBN58sRp+zfOc42BUJjkaVIxkFAPPwm7YssJxrP
         cuvkTD7KOMFuutDctkSBEExSkvjV10c/ZBSk/eaTePDEsYFsjzTIyJK8xwd3g3euOePq
         Q3ScCJaIOmqoXvBrXcFVweEpiGoxn6ZWwSl9vCKX6sS3mdbLR3BnW0M/a2hSPGxgzdpY
         FmnQ==
X-Received: by 10.68.211.195 with SMTP id ne3mr15136296pbc.121.1406258175700;
        Thu, 24 Jul 2014 20:16:15 -0700 (PDT)
Received: from [127.0.0.1] ([223.185.254.103])
        by mx.google.com with ESMTPSA id zn9sm27314500pac.31.2014.07.24.20.16.12
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 20:16:15 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <53D17919.4020702@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254194>



On 7/25/2014 2:52 AM, Ramsay Jones wrote:
> On 24/07/14 20:54, Junio C Hamano wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> If we take the easy way out, fixing UI mistakes would be easier,
>>> just replace git_config_cache() with git_config_raw() for such cases.
>>
>> I do not think that would fly well.
>>
>> The kind of "let's migrate funcname users to xfuncname while still
>> supporting the old uses" change will be done in the callback
>> functions like userdiff_config().  But it is very typical that
>> multiple config callback functions are cascaded (e.g. many
>> eventually end up calling git_default_core_config()); in order to a
>> workaround you suggest to help a callback in deep in a cascade chain
>> would require you to see which ones among all the callback functions
>> will eventually call the callback you are updating for migration and
>> update all git_config() calls to git_config_raw().
>>
>> If you fix it properly (assuming it is feasible; I haven't heard if
>> you even tried to see how much work it would involve), you do not
>> need to introduce "git_config_cached()" (or "_raw()" for that
>> matter), which is a huge plus.  git_config() would instead do the
>> right thing automatically, giving the same semantics except that it
>> does not read the same file twice when it is known that the file has
>> not changed.
>>
> 
> I haven't been following this conversation too closely, so if I have
> grasped the wrong end of this stick, please accept my apologies! ;-)
> 
> Usually if you need to iterate the values in a hash-table in the order
> of key insertion, you would simply link the hash-table entries into a
> linked list. This assumes that the keys are distinct, or if not, that
> you are using a 'multi-map' type of hash-table. Here, if memory serves
> me, you are doing the 'multi' bit yourself within the single hash-table
> entry for a given key; so its not quite so easy.
> 
> However, I think it you could create a list of <pointer to hash-table
> entry, string-list index> pairs in the config_set and use that to do
> the iteration. A bit ugly, but it should work.
>

Thanks for the advice, that is exactly what I am doing.

> HTH
> 
> ATB,
> Ramsay Jones
> 
> 
> 

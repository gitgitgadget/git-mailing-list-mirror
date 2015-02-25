From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 1/2] sha1_file: Add sha1_object_type_literally and export
 it.
Date: Thu, 26 Feb 2015 01:29:41 +0530
Message-ID: <54EE29AD.4060802@gmail.com>
References: <54EDACC9.5080204@gmail.com>	 <1424862460-13514-1-git-send-email-karthik.188@gmail.com> <1424888526.2968.3.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 20:59:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQi7Z-0003Xv-ND
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 20:59:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbbBYT7p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2015 14:59:45 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:34702 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbbBYT7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2015 14:59:45 -0500
Received: by pdjg10 with SMTP id g10so7262286pdj.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2015 11:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=7DwzfxzrIydERrr9bsyWbMu9884GCvfoh03wvO/iH1U=;
        b=tf1kc/HO7srJb1mjq2bUs/tTOBnTHBDo9rz2WQ+hZcya5w/IqawhiV3CfMOdR/JOb2
         AR5HtWvAibFM0MvyP+j0RNjQkC+9GtVZHLJPUpguFihzZAmp2Br0+zvjDi6GD8lpzk+S
         QnMo76WMJ8r7Ul0dYuwESUNHSuUrIxAvk0IQbIKRNRxNbk2IWuy4nwDjUVXiZQLzZtE7
         eS7HDewT0GR8GqhOWrHIjRv65de72TwAHANDWkYJThzcPFWV+6zjnzxz/MnmTbXjiNf7
         ZH2WvE08D96vmpmJcEY6EvZcbCjTvDI/avqiEAxL1yRXJuO83jEqHhG+40XhTJtLqDy1
         rXOw==
X-Received: by 10.68.189.229 with SMTP id gl5mr8193784pbc.109.1424894384656;
        Wed, 25 Feb 2015 11:59:44 -0800 (PST)
Received: from [192.168.0.105] ([103.227.98.178])
        by mx.google.com with ESMTPSA id r5sm38265673pdc.81.2015.02.25.11.59.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Feb 2015 11:59:43 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <1424888526.2968.3.camel@leckie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264409>



On 02/25/2015 11:52 PM, David Turner wrote:
> On Wed, 2015-02-25 at 16:37 +0530, Karthik Nayak wrote:
>> +	unsigned long mapsize;
>> ...
>> +	map = map_sha1_file(sha1, &mapsize);
>
> I know this is a pre-existing issue, but I'm not sure "unsigned long" is
> the right type here.  Shouldn't it be a size_t?
I got the type from the function definition of map_sha1_file(), which is 
"void *map_sha1_file(const unsigned char *sha1, unsigned long *size)"
>
>> +	if (!map)
>> +		return -1;
>> +	if (unpack_sha1_header(&stream, map, mapsize, hdr, sizeof(hdr)) < 0)
>> +		status = error("unable to unpack %s header",
>> +			       sha1_to_hex(sha1));
>> +
>> +	for (i = 0; i < 32; i++) {
>
> This number should probably be a constant.
Do you want me to define it as a preprocessor directive?
>
>> +		if (hdr[i] == ' ') {
>> +			type[i] = '\0';
>> +			break;
>> +		}
>> +		type[i] = hdr[i];
>> +	}
>
> type might end up without a trailing \0 here in the case where hdr has
> no space in it.  Is this possible?
What's possible is when the object type name is greater than 32bytes 
"hdr" will not be able to hold the whole type, its a tradeoff, I guess I 
should put a null terminator at the end of "hdr". What do you suggest?
>
>

From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 3/5] run-command: Elaborate execvp error checking
Date: Wed, 25 Jan 2012 23:59:01 +0100
Message-ID: <op.v8nwsnyv0aolir@keputer.lokaal>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
 <4F205212.5080007@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>
To: "Johannes Sixt" <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jan 25 23:59:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqBo5-0003Mf-Jd
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 23:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868Ab2AYW7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 17:59:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:32842 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919Ab2AYW7D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 17:59:03 -0500
Received: by eekc14 with SMTP id c14so2823519eek.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 14:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=AOYeqWiKqgDMvYnPQHVbsXbGHjppGr7nJ6sRUckl6qQ=;
        b=HOpkeYeguQpmrf5K+p5w4vdcU7RLE6+i4BvApBgNJUXkNUBSlCLYE0MxJZrXuCgi7R
         joMNAP6HHfPv3oAtpkD954/DzwMX/uTNXEwXJNWI0FZno1tctd4tXJkx5JffHgVLv99i
         Khp2peuK77g69PmIHurnSMJTMGwOeERuDFheM=
Received: by 10.14.3.135 with SMTP id 7mr2288406eeh.80.1327532341893;
        Wed, 25 Jan 2012 14:59:01 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id 40sm7439725ees.10.2012.01.25.14.59.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 14:59:01 -0800 (PST)
In-Reply-To: <4F205212.5080007@kdbg.org>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189132>

On Wed, 25 Jan 2012 20:03:46 +0100, Johannes Sixt <j6t@kdbg.org> wrote:

> Am 24.01.2012 23:32, schrieb Frans Klaver:
>> +static void inspect_failure(const char *argv0, int silent_exec_failure)
>> +{
>> +	int err = errno;
>> +	struct strbuf sb = STRBUF_INIT;
>> +
>> +	/* errors not related to path */
>> +	if (errno == E2BIG || errno == ENOMEM)
>> +		die_file_error(argv0, err);
>> +
>> +	if (strchr(argv0, '/')) {
>> +		if (file_exists(argv0)) {
>> +			strbuf_add(&sb, argv0, strlen(argv0));
>> +			inspect_file(&sb, err, argv0);
>
> Can we end up here if errno == ENOENT? If so, silent_exec_failure must
> be checked. (inspect_file does not return.)

Hm, good catch. Yes, we can if the interpreter isn't found. I never  
intended to actually leave the "interpreter not found" ENOENT case in it's  
current shape, so it probably slipped through. Will fix inspect_failure  
here to guarantee silent_exec_failure is heeded. Patch 5/5 would probably  
remove it again.

Thanks.

From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/7] system_path(): Add prefix computation at runtime if RUNTIME_PREFIX set
Date: Mon, 18 Aug 2008 07:28:56 +0200
Message-ID: <6E4B0DFF-DD1D-450D-B02A-9A89E260DBCB@zib.de>
References: <1218977083-14526-1-git-send-email-prohaska@zib.de> <1218977083-14526-2-git-send-email-prohaska@zib.de> <1218977083-14526-3-git-send-email-prohaska@zib.de> <200808172243.09129.johannes.sixt@telecom.at>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Aug 18 07:30:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUxJm-0003Nm-1B
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 07:30:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbYHRF3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 01:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750848AbYHRF3I
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 01:29:08 -0400
Received: from mailer.zib.de ([130.73.108.11]:60541 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbYHRF3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 01:29:08 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m7I5SilB027688;
	Mon, 18 Aug 2008 07:28:49 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db957af.pool.einsundeins.de [77.185.87.175])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m7I5SgGg024643
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 18 Aug 2008 07:28:43 +0200 (MEST)
In-Reply-To: <200808172243.09129.johannes.sixt@telecom.at>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92679>


On Aug 17, 2008, at 10:43 PM, Johannes Sixt wrote:

> On Sonntag, 17. August 2008, Steffen Prohaska wrote:
>>
>> diff --git a/exec_cmd.c b/exec_cmd.c
>> index ce6741e..1622481 100644
>> --- a/exec_cmd.c
>> +++ b/exec_cmd.c
>> @@ -9,11 +9,51 @@ static const char *argv0_path;
>>
>> const char *system_path(const char *path)
>> {
>> -	if (!is_absolute_path(path) && argv0_path) {
>> -		struct strbuf d = STRBUF_INIT;
>> -		strbuf_addf(&d, "%s/%s", argv0_path, path);
>> -		path = strbuf_detach(&d, NULL);
>> +#ifdef RUNTIME_PREFIX
>> +	static const char *prefix;
>> +
>> +	if (!argv0_path) {
>> +		fprintf(stderr, "RUNTIME_PREFIX requested for path '%s', "
>> +				"but argv0_path not set.\n", path);
>
> If this happens, isn't this a logic error: assert(argv0_path)?

We could consider this a logic error.


>> 	}
>> +
>> +	if (!prefix) {
>> +		fprintf(stderr, "RUNTIME_PREFIX requested for path '%s', "
>> +				"but prefix computation failed.\n", path);
>
> Again a logic error?

The user can move the executable, so it's not a logic error.

	Steffen

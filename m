From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 04/18] fsck: Offer a function to demote fsck errors
 to  warnings
Date: Wed, 21 Jan 2015 18:42:37 +0100
Organization: gmx
Message-ID: <40ed6b0223f660712004d3a040163f8d@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
 <a749c4a2542c32dfe256c24000e5556ebb3ce26f.1421682369.git.johannes.schindelin@gmx.de>
 <xmqqppa8y0v4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:42:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDzIn-0002XV-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 18:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbbAURmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 12:42:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:65507 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbbAURmo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 12:42:44 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Li1hG-1XQtBM1CR0-00nA71; Wed, 21 Jan 2015 18:42:38
 +0100
In-Reply-To: <xmqqppa8y0v4.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:Zn5TDvtoIRclr37VrEeM2mnV9YhAtxGlh/yC2elRSQQfMd11RK9
 aAxDqrbuiRu8gG0r+7GldqrcGvZgM1MR8KAdf1WwmGyCwOw+XsA0oBoIuqiZ8Rp4hUSexIy
 +74kc1eAi7U+Oqmb/DXG8g7/LSipESgn5NYqpR4FZ25/rtT+7cy+28cYax17iTh+iMkDHIy
 tn2BnWmU7LN03f3nBJegw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262734>

Hi Junio,

On 2015-01-21 09:49, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> +static inline int substrcmp(const char *string, int len, const char *match)
>> +{
>> +	int match_len = strlen(match);
>> +	if (match_len != len)
>> +		return -1;
>> +	return memcmp(string, match, len);
>> +}
> 
> Is this what we call "starts_with()" these days?

Unfortunately not quite: It really requires the substring specified by `string` and `len` to be identical to the full `match`. For example, `substrcmp("Hello world!", 5, "Hell")` would report a failure (because the substring "Hello" is *not* matching "Hell"), while `starts_with("Hello world!", "Hell")` would obviously succeed.

>> +void fsck_set_severity(struct fsck_options *options, const char *mode)
>> +{
>> +	int severity = FSCK_ERROR;
>> +
>> +	if (!options->msg_severity) {
>> +		int i;
>> +		int *msg_severity = malloc(sizeof(int) * FSCK_MSG_MAX);
> 
> xmalloc()?

Absolutely! Fixed.

Thanks,
Dscho

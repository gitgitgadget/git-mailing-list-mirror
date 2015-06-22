From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v7 04/19] fsck: Offer a function to demote fsck errors
 to warnings
Date: Mon, 22 Jun 2015 23:00:18 +0200
Organization: gmx
Message-ID: <4037772e17652ba93638434294c9512c@www.dscho.org>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
 <08ab723892b4412431b88df8764f506f0abbb0a6.1434986506.git.johannes.schindelin@gmx.de>
 <xmqq616fiqz7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:01:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78pv-0005xf-DO
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:00:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbbFVVAy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:00:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:58784 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbbFVVAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 17:00:41 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LbgyV-1YfTdg3SQ7-00lAZh; Mon, 22 Jun 2015 23:00:19
 +0200
In-Reply-To: <xmqq616fiqz7.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:C+v3SdJZZ5z/BUc9jo70m4dFX8M+cS2b8vEzbKTZy0I6cKVJvsV
 BTxnbx+vmZ6PCFlUtKzSGMbeJX+v+9o50CGReaeobUljRkZDohnitLRQUkVwbbzakDSoRlo
 voZG7Cfq2fR/SRhVibAh9j4cKEBfpOfZ5kDZdCTULu9gQ+0Tn/O2Yuu4FHhPSMiIKeHbZ02
 QW7MmC+RZqTg+5fpK0Sgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YSVUXIcAegU=:d+vTgOHs2vsjr7q9NUiUn2
 co11c/Il/DQNmeerLtmgWO50oseYzhO87G1EPWNcmxu/doh6bwZjUi/Neb4OZNSpFALFU8onO
 kGInIPnD/f3D3crSfZLt5eF8xmUVg+mi5xfTpGysYOTcK35DsblbDQu8UG3JsOYu2pBRJvSPi
 HzFiQGmThP8UoRzco61Ifra6fD0VxQFDJG85ROCy8fCpqsihF9FRaRjppvZsxgCIVzGqHCD77
 zjZ+3RJpGy7s3/ISuq6cRkjtfAcgmOHSbscM6GQUqJuDhrl9oLTFx17dsjzHnaWthgnAAsDt+
 MF7CdYqPL0DyXNcY01/tZXxDkmW4QzbHgmCg/+1SikUuj5bVMwduRXdiPt5yjGp+f7g/ycwfj
 JU723qwz3fgH6cBGr9Yr400UcD4eCczMpIF6LUxtkh+npJzQSwTWKNhkklvrlMSld3avL464Z
 9wNaDS4UJErnJokwh1zdgPuPku8FMEkYQDaOzNSdN9jwBGx3yaKeJTcz2n06ueUPdgLfKo314
 82wfuBHNzopFpvsramDH4m+tcwBjCczRA6pG/GFMiLGTHZhwA1DYaCzJOCuSMG1gyMJJRtyv2
 UYENa5MLNufn8G1X/LodganYtXK9pjv/ZlhBfqqKEW2pjeXl9HEFGe0VUuJ4zH8Xu8NYHcG1/
 /5pPzYWxiki1EbCLZw7AGUcgBwzSaDSySErYkppy6RcHKkuewk5NQq+3WzWaD1RgBvbk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272412>

Hi Junio,

On 2015-06-22 19:37, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> diff --git a/fsck.c b/fsck.c
>> index 1a3f7ce..e81a342 100644
>> --- a/fsck.c
>> +++ b/fsck.c
>> @@ -64,30 +64,29 @@ enum fsck_msg_id {
>>  #undef MSG_ID
>>
>>  #define STR(x) #x
>> -#define MSG_ID(id, msg_type) { STR(id), FSCK_##msg_type },
>> +#define MSG_ID(id, msg_type) { STR(id), NULL, FSCK_##msg_type },
>>  static struct {
>>  	const char *id_string;
>> +	const char *lowercased;
>>  	int msg_type;
>>  } msg_id_info[FSCK_MSG_MAX + 1] = {
>>  	FOREACH_MSG_ID(MSG_ID)
>> -	{ NULL, -1 }
>> +	{ NULL, NULL, -1 }
>>  };
>>  #undef MSG_ID
>>
>>  static int parse_msg_id(const char *text)
>>  {
>> -	static char **lowercased;
>>  	int i;
>>
>> -	if (!lowercased) {
>> +	if (!msg_id_info[0].lowercased) {
>>  		/* convert id_string to lower case, without underscores. */
>> -		lowercased = xmalloc(FSCK_MSG_MAX * sizeof(*lowercased));
>>  		for (i = 0; i < FSCK_MSG_MAX; i++) {
>>  			const char *p = msg_id_info[i].id_string;
>>  			int len = strlen(p);
>>  			char *q = xmalloc(len);
>>
>> -			lowercased[i] = q;
>> +			msg_id_info[i].lowercased = q;
>>  			while (*p)
>>  				if (*p == '_')
>>  					p++;
>> @@ -98,7 +97,7 @@ static int parse_msg_id(const char *text)
>>  	}
>>
>>  	for (i = 0; i < FSCK_MSG_MAX; i++)
>> -		if (!strcmp(text, lowercased[i]))
>> +		if (!strcmp(text, msg_id_info[i].lowercased))
>>  			return i;
>>
>>  	return -1;
> 
> Heh, this was the first thing that came to my mind when I saw 03/19
> that lazily prepares downcased version (which is good) but do so in
> a separately allocated buffer (which is improved by this change) ;-)
> 
> IOW, I think all of the above should have been part of 03/19, not
> "oops I belatedly realized that this way is better" fixup here.

Gaaaah. Wrong commit fixed up. Sorry. Will be fixed in v8.

>> +void fsck_set_msg_types(struct fsck_options *options, const char *values)
>> +{
>> +	char *buf = xstrdup(values), *to_free = buf;
>> +	int done = 0;
>> +
>> +	while (!done) {
>> +		int len = strcspn(buf, " ,|"), equal;
>> +
>> +		done = !buf[len];
>> +		if (!len) {
>> +			buf++;
>> +			continue;
>> +		}
>> +		buf[len] = '\0';
>> +
>> +		for (equal = 0; equal < len &&
>> +				buf[equal] != '=' && buf[equal] != ':'; equal++)
> 
> Style.  I'd format this more like so:
> 
> 		for (equal = 0;
>                      equal < len && buf[equal] != '=' && buf[equal] != ':';
> 		     equal++)

Will be fixed.

>> +			buf[equal] = tolower(buf[equal]);
>> +		buf[equal] = '\0';
>> +
>> +		if (equal == len)
>> +			die("Missing '=': '%s'", buf);
>> +
>> +		fsck_set_msg_type(options, buf, buf + equal + 1);
>> +		buf += len + 1;
>> +	}
>> +	free(to_free);
>> +}
> 
> Overall, the change is good (and it was good in v6, too), and I
> think it has become simpler to follow the logic with the upfront
> downcasing.

Yep, I agree. I did not expect that, but it was worth the effort to compare the two versions.

Ciao,
Dscho

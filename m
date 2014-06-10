From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1] config: Add hashtable for config parsing & retrival
Date: Tue, 10 Jun 2014 07:51:13 -0400
Message-ID: <CAPig+cSjAxVN8GLit-nZ9sUxmMvC1KcSFMJayJSarQEcqyYvjw@mail.gmail.com>
References: <1402318146-5062-1-git-send-email-tanayabh@gmail.com>
	<1402318146-5062-2-git-send-email-tanayabh@gmail.com>
	<vpqmwdmtb2o.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Tanay Abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>, Torsten Bogershausen <tboegi@web.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 10 13:51:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuKaE-0005xr-E2
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 13:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaFJLvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 07:51:14 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:53329 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbaFJLvN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 07:51:13 -0400
Received: by mail-yk0-f170.google.com with SMTP id q9so1214537ykb.15
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 04:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=QbDrCMSdA38dRMVHbn3mw50decd4tR9plwM3AvjhtZE=;
        b=MtjPnClMutKJ7ZQN9FOw8Dk/B1CohNSg8Mx9m5OudF8DJeDY6UlpkRuFMTiBQHiIo1
         TlzE0QDGXF0bp8iGEQCcfFGYctVNXoqZOZ4+FXKnUFIQ6mQnKP1r5u3GwL8EgtfmYEWf
         uZTTsCXe/iDNxp6JczVOkZDA/7Rj3UzAoVYAPKbv5uYxzFloi4SgFZaw2dhNLkCIsSSb
         NoaxuIX7Vd1kdzI2RlyhdvGmX+XpTwaZAVhPKRlxxNQHgKYfkx1O3cC7ahTn/59rGnEv
         RVToRMI7zX2q4tNKhMrw7UOUvy36UJgoqMPHODuZKvoKoMYwnRZcTu/4fbCOGuegzAV2
         yuTA==
X-Received: by 10.236.134.169 with SMTP id s29mr23858617yhi.4.1402401073201;
 Tue, 10 Jun 2014 04:51:13 -0700 (PDT)
Received: by 10.170.169.65 with HTTP; Tue, 10 Jun 2014 04:51:13 -0700 (PDT)
In-Reply-To: <vpqmwdmtb2o.fsf@anie.imag.fr>
X-Google-Sender-Auth: dn0VW3_ZVNTcVEZ9wTrte88RHGE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251180>

On Mon, Jun 9, 2014 at 10:24 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Tanay Abhra <tanayabh@gmail.com> writes:
>> +struct config_cache_entry {
>> +     struct hashmap_entry ent;
>> +     char *key;
>> +     struct string_list *value_list;
>> +};
>
> I guess this crossed Eric's remark about the fact that this is a
> pointer.
>
>> +static void config_cache_free(void)
>
> I didn't look closely enough to make sure there were no memory leak
> remaining, but did you check with valgrind --leak-check that it is the
> case in practice?

It does leak the config_cache_entry::value_list member which was
xcalloc()'d in config_cache_set_value().  (I didn't mention it in my
reviews because I was expecting 'value_list' to be changed to a plain
structure rather than a pointer to a structure.)

From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] make color.ui default to 'auto'
Date: Wed, 15 May 2013 18:52:35 +0200
Message-ID: <vpq61ykfang.fsf@grenoble-inp.fr>
References: <CALKQrgdVf_rfsLu1NnXGk+LCTV34T-4doJ+2yyi69ZER8vTAfg@mail.gmail.com>
	<1368624095-15738-1-git-send-email-Matthieu.Moy@imag.fr>
	<7vtxm4cjil.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 18:53:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucexe-0004df-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 18:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932962Ab3EOQxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 12:53:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37455 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932902Ab3EOQxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 12:53:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r4FGqXDB006991
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 15 May 2013 18:52:33 +0200
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1UcewN-0000Df-IY; Wed, 15 May 2013 18:52:35 +0200
In-Reply-To: <7vtxm4cjil.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 15 May 2013 09:09:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 15 May 2013 18:52:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r4FGqXDB006991
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1369241554.31136@Lg3LkjOjP5oEGr6EE0LjnA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224423>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> diff --git a/builtin/config.c b/builtin/config.c
>> index 000d27c..ecfceca 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -316,7 +316,7 @@ static void get_color(const char *def_color)
>>  
>>  static int get_colorbool_found;
>>  static int get_diff_color_found;
>> -static int get_color_ui_found;
>> +static int get_color_ui_found = GIT_COLOR_AUTO;
>
> It is curious to notice that we have these three and only one is
> initialized to the new default value, while the other two get -1
> at the beginning of get_colorbool().

Right. The meaning of the _found suffix is clear for the first two, but
not the last.

> I wonder if it would be cleaner to statically initialize all three
> to -1 here, drop the assignment of -1 to two of them from the
> beginning of get_colorbool(), and then have a final fallback inside
> the want_color() call itself, i.e.

I've left the assignments within the function (I like the initialisation
right before usage, I don't have to worry about how many times the
function is called then), but I've added a patch that initializes
get_color_ui_found to -1 like the others, and does essentially this:

> 	get_colorbool_found = want_color(get_colorbool_found < 0
>         				? GIT_COLOR_AUTO
>                                         : get_colorbool_found);

Except I've made it a separate if statement. Then PATCH 2/2 is really
crystal clear.

Reroll comming, with an improved commit message that should adress the
points in the other message.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

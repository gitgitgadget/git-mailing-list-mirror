From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3] Do not decode url protocol.
Date: Tue, 22 Jun 2010 19:08:31 +0200
Message-ID: <vpqfx0fxaeo.fsf@bauges.imag.fr>
References: <AANLkTik2M4Wxa-C6iRf7ShlcrwXu1ALNXtKwbA-mO5ge@mail.gmail.com>
	<vpq39wf82y3.fsf@bauges.imag.fr> <4C20E92B.1030405@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: pascal@obry.net
X-From: git-owner@vger.kernel.org Tue Jun 22 19:08:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR6xo-00025V-Oi
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 19:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752788Ab0FVRIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 13:08:39 -0400
Received: from mx1.imag.fr ([129.88.30.5]:37905 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750833Ab0FVRIi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 13:08:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o5MH09n4004752
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 22 Jun 2010 19:00:09 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OR6xb-0002QY-Dc; Tue, 22 Jun 2010 19:08:31 +0200
In-Reply-To: <4C20E92B.1030405@obry.net> (Pascal Obry's message of "Tue\, 22 Jun 2010 18\:47\:39 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 22 Jun 2010 19:00:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o5MH09n4004752
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1277830813.60622@8g/nSTFQFqET6cgV4MeAqg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149485>

Pascal Obry <pascal.obry@gmail.com> writes:

> Matthieu,
>
>> Unless I missed something, this version doesn't address my earlier
>> comment:
>
> Because I do not agree.

I'm fine with disagreeing, but then you should argue. This would allow
either Junio to be convinced, or me to argue back.

> The three procedures:
>
> char *url_decode(const char *url)
> char *url_decode_parameter_name(const char **query)
> char *url_decode_parameter_value(const char **query)
>
> are all passed a full url (with protocol).

The caller is this (http-backend.c):

static struct string_list *get_parameters(void)
{
[...]
		while (query && *query) {
			char *name = url_decode_parameter_name(&query);
			char *value = url_decode_parameter_value(&query);
			[...]
		}

which advances "query" as the URL is decoded, hence passing query as a
pointer to the argument being parsed, not to the full URL.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

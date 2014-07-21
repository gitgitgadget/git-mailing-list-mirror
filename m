From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 0/6] git_config callers rewritten with the new config cache API
Date: Mon, 21 Jul 2014 16:27:37 +0200
Message-ID: <vpqlhrm4wiu.fsf@anie.imag.fr>
References: <1405941145-12120-1-git-send-email-tanayabh@gmail.com>
	<vpqegxeeuyb.fsf@anie.imag.fr> <53CD1280.1080107@gmail.com>
	<vpqy4vmakq3.fsf@anie.imag.fr> <53CD1D0F.5000605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 16:28:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9EZK-00035j-94
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 16:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbaGUO1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 10:27:55 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40409 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932298AbaGUO1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 10:27:54 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6LERaHr019578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jul 2014 16:27:36 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6LERb4U026016;
	Mon, 21 Jul 2014 16:27:37 +0200
In-Reply-To: <53CD1D0F.5000605@gmail.com> (Tanay Abhra's message of "Mon, 21
	Jul 2014 19:30:47 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 21 Jul 2014 16:27:43 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6LERaHr019578
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406557664.79491@g50WuHt5RqvCLwx7j7Bxbg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253971>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/21/2014 7:15 PM, Matthieu Moy wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> On 7/21/2014 6:21 PM, Matthieu Moy wrote:
>>>> 2) Add a by-address parameter to git_configset_get_value that allows the
>>>>    user to get the file and line information. In your previous patch,
>>>>    that would mean returning a pointer to the corresponding struct
>>>>    key_source.
>>>
>>> Will this extra complexity be good for "git_configset_get_value"?
>>> Instead can we provide a function like die_config(char *key)
>>> which prints
>>> 	die("bad config file line %d in %s", linenr, filename);?
>> 
>> Where would you call this function, and where would you take linenr and
>> filename?
>>
>
> Usage can be like this,
>
> if(!git_config_get_value(k, &v)) {
> 	if (!v) {
> 		config_error_nonbool(k);
> 		die_config(k);
> 		/* die_config calls git_config_get_value_multi for 'k',
> 		 * gets the string list with the util pointer containing
> 		 * the linenr and the file name, dies printing the message.
> 		 */
> 	} else
> 		/* do work */
> }

OK, so you query the cache twice (which is OK, it's cheap and happens
just once before dying). That would work too.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

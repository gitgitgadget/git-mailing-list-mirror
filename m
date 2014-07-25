From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC PATCH 1/3] config --global --edit: create a template file if needed
Date: Fri, 25 Jul 2014 18:01:53 +0200
Message-ID: <vpqtx65ctqm.fsf@anie.imag.fr>
References: <1406295891-7316-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAPig+cSyLtUmkxAcO+iatKSS2t2T5byXRrJYq=MSuBoZ3m=hcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 18:02:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAhx4-0001CB-Ms
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 18:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760785AbaGYQCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2014 12:02:22 -0400
Received: from mx1.imag.fr ([129.88.30.5]:49544 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760675AbaGYQCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 12:02:21 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s6PG1qHx024101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 Jul 2014 18:01:52 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s6PG1r5F021907;
	Fri, 25 Jul 2014 18:01:53 +0200
In-Reply-To: <CAPig+cSyLtUmkxAcO+iatKSS2t2T5byXRrJYq=MSuBoZ3m=hcw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 25 Jul 2014 11:37:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 25 Jul 2014 18:01:52 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s6PG1qHx024101
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1406908914.64213@1msCZYs5cQHwu4uC3yZ0AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254230>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> +static char *default_user_config()
>> +{
>> +       struct strbuf buf = STRBUF_INIT;
>> +       strbuf_addf(&buf,
>> +                   _("# This is Git's user-wide configuration file.\n"
>> +                     "[core]\n"
>> +                     "# Please, adapt and uncomment the following lines:\n"
>> +                     "#        user = %s\n"
>> +                     "#        email = %s\n"),
>
> "[core]", "user =", "email =" should not be translated. Would it make
> sense to keep these outside of _()?

I would say no, as the code and the string to translate would be much
less readable without core, user and email inline.

Were you suggesting stg like

_("# This is Git's user-wide configuration file.\n"
  "[%s]\n"
  "# Please, adapt and uncomment the following lines:\n"
  "#        %s = %s\n"
  "#        %s = %s\n"),
  "core", "name", ..., "email", ...

?

>> +                       if (fd) {
>> +                               char *content = default_user_config();
>> +                               write_str_in_full(fd, content);
>
> close(fd);

Indeed.

>> +                               free(content);
>> +                       }
>> +                       else if (errno != EEXIST)
>> +                               die_errno(_("Cannot create configuration file %s"), config_file);
>
> Other error messages in this file (including those just above this
> block) begin with a lowercase letter.

Applied.

Thanks,

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

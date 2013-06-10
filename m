From: =?UTF-8?Q?Mathieu_Li=C3=A9nard--Mayor?= 
	<mathieu.lienard--mayor@ensimag.fr>
Subject: Re: [PATCH v2 1/2] rm: better error message on failure for multiple  files
Date: Mon, 10 Jun 2013 16:57:00 +0200
Message-ID: <580989b4b95a7302a42c7f25024c3375@ensibm.imag.fr>
References: <1370874127-4326-1-git-send-email-Mathieu.Lienard--Mayor@ensimag.imag.fr>
 <vpqtxl6ghf5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>,
	<git@vger.kernel.org>, <gitster@pobox.com>,
	Jorge Juan Garcia Garcia 
	<Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 10 16:58:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um3YU-0004Ig-9v
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 16:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374Ab3FJO6m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Jun 2013 10:58:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:60541 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751429Ab3FJO6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 10:58:40 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5AEuxg4005666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 10 Jun 2013 16:56:59 +0200
Received: from web-ensimag.imag.fr (web-ensimag.imag.fr [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5AEv0FR015954;
	Mon, 10 Jun 2013 16:57:00 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id r5AEv0Ds010228;
	Mon, 10 Jun 2013 16:57:00 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id r5AEv0kr010217;
	Mon, 10 Jun 2013 16:57:00 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to mathieu.lienard--mayor@ensimag.fr using -f
In-Reply-To: <vpqtxl6ghf5.fsf@anie.imag.fr>
X-Sender: mathieu.lienard--mayor@ensimag.fr
User-Agent: Roundcube Webmail/0.8.1
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Mon, 10 Jun 2013 16:56:59 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227298>

Le 2013-06-10 16:38, Matthieu Moy a =C3=A9crit=C2=A0:
> Mathieu Lienard--Mayor <Mathieu.Lienard--Mayor@ensimag.imag.fr>=20
> writes:
>
>> When 'git rm' fails, it now displays a single message
>> with the list of files involved, instead of displaying
>> a list of messages with one file each.
>>
>> As an example, the old message:
>> 	error: 'foo.txt' has changes staged in the index
>> 	(use --cached to keep the file, or -f to force removal)
>> 	error: 'bar.txt' has changes staged in the index
>> 	(use --cached to keep the file, or -f to force removal)
>>
>> would now be displayed as:
>> 	error: the following files have changes staged in the index:
>> 	    foo.txt
>> 	    bar.txt
>> 	(use --cached to keep the file, or -f to force removal)
>>
>> Signed-off-by: Mathieu Lienard--Mayor=20
>> <Mathieu.Lienard--Mayor@ensimag.imag.fr>
>> Signed-off-by: Jorge Juan Garcia Garcia=20
>> <Jorge-Juan.Garcia-Garcia@ensimag.imag.fr>
>> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>list
>
> There's a "list" after my email, probably a typo.
yes, that's a leftover from a rebase-i
>
>> +/*
>> + * PRECONDITION: files_list is a non-empty string_list
>> + */
>
> Avoid repeating in comments what the code already says. "file_list is
> non-empty" is sufficient, we already know it's a string_list.
Okay
>
>> +	if (files_staged.nr)
>> +		errs =3D print_error_files(&files_staged,
>> +					 _("the following files have staged "
>> +					   "content different from both the"
>> +					   "\nfile and the HEAD:"),
>> +					 _("\n(use -f to force removal)"));
>> +	if (files_cached.nr)
>> +		errs =3D print_error_files(&files_cached,
>> +					 _("the following files have changes "
>> +					   "staged in the index:"),
>> +					 _("\n(use --cached to keep the file, "
>> +					   "or -f to force removal)"));
>
> What happens if both conditions are true? It seems the second will
> override the first. I think it'd be OK because what matters is that=20
> errs
> is set by someone, no matter who, and the error message is displayed=20
> on
> screen, not contained in the variable, but this looks weird.
>
> I'd find it more readable with "errs |=3D print_error_files(...)".
Well the current code is only using errs=3Derror(...), using the same=20
variable errs over and over, no matter how many times it loops.
That's why i implemented it similarly.
>
> And actually, you may want to move the if (....nr) inside
> print_error_files (wich could then be called=20
> print_error_files_maybe).
>
> At least, there should be a test where two conditions are true.
I'll do that, to be sure about the behaviour.
>
>> +	if (files_submodule.nr)
>> +		errs =3D print_error_files(&files_submodule,
>> +					 _("the following submodules (or one "
>> +					   "of its nested submodule) use a "
>> +					   ".git directory:"),
>> +					 _("\n(use 'rm -rf' if you really "
>> +					   "want to remove i including all "
>
> i -> it
> ?

--=20
Mathieu Li=C3=A9nard--Mayor,
2nd year at Grenoble INP - ENSIMAG
(+33)6 80 56 30 02

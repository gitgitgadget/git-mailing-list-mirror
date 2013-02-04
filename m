From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] for-each-repo: new command used for multi-repo
 operations
Date: Sun, 03 Feb 2013 22:41:41 -0800
Message-ID: <7vip6860nu.fsf@alter.siamese.dyndns.org>
References: <1359290777-5483-1-git-send-email-hjemli@gmail.com>
 <1359290777-5483-2-git-send-email-hjemli@gmail.com>
 <7vk3qywiqf.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6GTVgY4DK-FLELGF-Cb1=iNYyWcUsUiaUytGRx9Tr4Ow@mail.gmail.com>
 <20130128081006.GA2434@elie.Belkin> <7vham1xktx.fsf@alter.siamese.dyndns.org>
 <CAFXTnz6xBMo42jWdqahYX-bnTBucVmQpFPN29X8tGRd7L=g2wQ@mail.gmail.com>
 <7vr4l5w385.fsf@alter.siamese.dyndns.org> <5106DBB7.70007@web.de>
 <7vlibdvyh3.fsf@alter.siamese.dyndns.org> <5106ECB6.9010801@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 07:42:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2Fkl-00072x-Ho
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 07:42:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab3BDGlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 01:41:45 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58402 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751557Ab3BDGlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 01:41:44 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D54C58B91;
	Mon,  4 Feb 2013 01:41:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P35fPSyia4OI1UTPm3X6rBrjz7o=; b=dVEwTo
	8B/3iacP3TQWnuGAtUGpFMlhzoemoL08n9eR8WmtnnlPiVbDaEYBs6sO92h1BRdO
	o5cYW67uiUj+iQq63Op3AS2rh5gNGJsJE5bhzoanqbJ6MdLJNbXn3PEed9Qfp3Xq
	N6tRbEIhLE2+IZzsiBtWxjPqKtvoZyhnTIb5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NGMUGzkmGOw9YsUI7rP/HO1DOB8zNhce
	fIKt3EsrNAplfMFgFTsECtdOedOj8bK47sFDZfbsKJEtIYOSCRKxBKYC8DhcW6Wr
	eO7RmKtfpgJ8jfY7eiMnulyroN7mwb0Eurm8nPGL8Uft7oz6YH/Hqmiz+Ch99N2X
	Zh0YKoSCN3Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9BE58B90;
	Mon,  4 Feb 2013 01:41:43 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 311B38B8F; Mon,  4 Feb 2013
 01:41:43 -0500 (EST)
In-Reply-To: <5106ECB6.9010801@web.de> (Jens Lehmann's message of "Mon, 28
 Jan 2013 22:25:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F02031B2-6E95-11E2-8C14-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215358>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 28.01.2013 21:34, schrieb Junio C Hamano:
> ...
>> I was imagining that "foreach --untracked" could go something like this:
>> 
>>  * If you are inside an existing git repository, read its index to
>>    learn the gitlinks in the directory and its subdirectories.
>> 
>>  * Start from the current directory and recursively apply the
>>    procedure in this step:
>> 
>>    * Scan the directory and iterate over the ones that has ".git" in
>>      it:
>> 
>>      * If it is a gitlinked one, show it, but do not descend into it
>>        unless --recursive is given (e.g. you start from /home/jens,
>>        find /home/jens/proj/ directory that has /home/jens/proj/.git
>>        in it.  /home/jens/.git/index knows that it is a submodule of
>>        the top-level superproject.  "proj" is handled, and it is up
>>        to the --recursive option if its submodules are handled).
>> 
>>      * If it is _not_ a gitlinked one, show it and descend into it
>>        (e.g. /home/jens/ is not a repository or /home/jens/proj is
>>        not a tracked submodule) to apply this procedure recursively.
>> 
>> Of course, without --untracked, we have no need to iterate over the
>> readdir() return values; instead we just scan the index of the
>> top-level superproject.
>
> Thanks for explaining, that makes tons of sense.

There is a small thinko above, though, and I'd like to correct it
before anybody takes the above too seriously as _the_ outline of the
design and implements it to the letter.

The --recursive option should govern both a tracked submodule and an
untracked one.  When asking to list both existing submodules and
directories that could become submodules, you should be able to say

	$ git submodule foreach --untracked

to list the direct submodules and the directories with .git in them
that are not yet submodules of the top-level superproject, but the
latter is limited to those with no parent directories with .git in
them (other than the top-level of the working tree of the
superproject).  With

	$ git submodule foreach --untracked --recursive

you would see submodules and their submodules recursively, and also
directories with .git in them (i.e. candidates to become direct
submodules of the superproject) and the directories with .git in
them inside such submodule candidates (i.e. candidates to become
direct submodules of the directories that could become direct
submodules of the superproject) recursively.

If we set things up this way:

	mkdir -p a/b c/d &&
	for d in . a a/b c c/d
        do
		git init $d &&
                ( cd $d && git commit --allow-empty -m initial )
	done &&
        git add a &&
        ( cd a && git add b )

The expected results for various combinations are:

 * "git submodule foreach" would visit 'a' and nothing else;
 * "git submodule foreach --recursive" would visit 'a' and 'a/b';
 * "git submodule foreach --untracked" would visit 'a' and 'c'; and
 * "git submodule foreach --untracked --recursive" would visit all four.

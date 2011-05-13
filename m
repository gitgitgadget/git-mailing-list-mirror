From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Document translation with po4a.
Date: Fri, 13 May 2011 09:48:28 -0700
Message-ID: <7v39ki8s2r.fsf@alter.siamese.dyndns.org>
References: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Osamu OKANO <okano.osamu@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 18:48:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKvXe-0007f3-3R
	for gcvg-git-2@lo.gmane.org; Fri, 13 May 2011 18:48:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759589Ab1EMQsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2011 12:48:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40298 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759568Ab1EMQsg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2011 12:48:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A3F2F4AD4;
	Fri, 13 May 2011 12:50:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4rPmOdxvdVLaNYwKRPwM9zy9G/o=; b=JZauBg
	mMoSIfu/3tHSwA5uvfrg+UlFwDdnJieo4L5uS3Cc2FySdLyi48g44pHUZrG1asQW
	MNsYbSXzGjSC+VRkEEIwLRdmWSuFpWT7T2KUhLEDnDH8GAod+RCvWiXF8t6TQOW4
	OzZb9Ssp8/GU35mKTEhvgn1IdFzmwByZippL8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ggN87cUQF0jlIuEZJB6aNLUIIEGpQDt6
	dDVljeoxa1Wjp/bTtzel1lAgCzynrwN7CzL9TZuvP5h0fElcwCdsS2Pncz0L8EEz
	ouxJ7yaFMdzJ0mfbQeUTWKmm4Yoy/M/nBmuA+PlWW5DmTNFcB+HWPsfl/ex7/WDy
	PqqQLX/So9I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 814224AD2;
	Fri, 13 May 2011 12:50:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 55BC84AD1; Fri, 13 May 2011
 12:50:35 -0400 (EDT)
In-Reply-To: <1305292458-3920-1-git-send-email-okano.osamu@gmail.com> (Osamu
 OKANO's message of "Fri, 13 May 2011 22:14:11 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2153B6F8-7D81-11E0-B249-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173548>

Osamu OKANO <okano.osamu@gmail.com> writes:

> 1 Document translation with po4a. 
> ---------------------------------
> I tried to translate Docmentation with po4a.
> Please relive my translation flow.

Thanks for a fun read.

Do I understand correctly that this "patchset" is primarily for you to
request comments on, and it is not about adding it literally as "this
gives a good framework for documentation i18n and demonstrates l10n with a
sample page translated to Japanese"?

I have a few comments on the overall structure.

First of all, I would prefer to have these in "po" subdirectory of
Documentation.

Something like:

     Documentation/
                  /Makefile
                  /asciidoc.conf
                  /git-stash.txt
                  /po/ (new directory)
                  /po/.gitignore
                  /po/Makefile
                  /po/pot/git-stash.pot
                  /po/ja/git-stash.po
                  /po/ko/git-stash.po
                  /po/ru/git-stash.po


Then from the end-user's point of view (not from the translators), I would
like to see Documentation/po/Makefile that lets me say

	cd Documentation/po && make html man install

which would first create Documentation/po/*/*.txt files using the
corresponding .po files and the base documentation, and then run asciidoc
to format them into Documentation/po/*/*.{html,[1-8]}, and install them to
their final destination (e.g. /usr/share/man/$lang/man[1-8], but it is
likely that you have to make it configurable).

When all of the above works solidly, Documentation/Makefile can learn a
new rule to make "cd Documentation && make (man|html|install)" would
descend to Documentation/po and run a corresponding make there.

Broadly, there are four kinds of things to keep l10n up-to-date.

 - Starting a new documentation page
   . add Documentation/po/pot/$newpage.pot for Documentation/$newpage.txt
   . commit the addition of Documentation/po/pot/$newpage.pot

 - Updating the .pot from documentation

 - Starting a new language
   . create a subdirectory in Documentation/po/$lang
   . copy Documentation/po/*.pot to Documentation/po/$lang/ and translate
   . test with the above "end-user" procedure.
   . commit the addition of Documentation/po/$lang/*.po

 - Updating an existing documentation page
   . edit Documentation/po/$lang/$page.po
   . test with the above "end-user" procedure.
   . commit the resulting Documentation/po/$lang/$page.po

 - Keeping your Documentation/po/$lang/*.pot up-to-date
   . find Documentation/po/pot/$page.pot without Documentation/po/$lang/$page.po
   . update Documentation/po/$lang/*.po from corresponding Documentation/pot/*.pot

We may want to have a rule in Documentation/po/.gitignore to ignore
everything except a select few, namely Makefile, pot/*.pot, po/*/*.po,
in order to avoid mistakes.

We also may want to have targets in Documentation/po/Makefile to help the
translators carrying out the above set of tasks.  "make lang=ja update"
may do the following (just thinking aloud):

 - create Documentation/po/$(lang)/, if the directory does not exist.

 - for all Documentation/po/pot/%.pot,
   . if Documentation/po/$(lang)/%.po does not exist, copy po/pot/%.pot to
     po/$(lang)/%.po, and optionally "git add -N" the latter
   . otherwise, update po/$(lang)/%.po with po/pot/%.pot using po4a-updatepo

 - for all Documentation/po/$(lang)/%.po,
   . "git rm --cached" it if Documentation/po/pot/%.pot does not exist.

I deliberately left the management of *.pot (i.e. the first two tasks in
the above list)outside the scope of "make update" run in Documentation/po/
directory.  It often is easier for the i18n coordinators to manage if
everybody works on translating the same version of documentation strings.

I would expect the overall project workflow to be:

 - A developer can add or modify Documentation/*.txt to document new
   commands any time without having to worry about documentation i18n.

 - A translator may tweak wording in Documentation/po/$(lang)/*.po any
   time.

 - From time to time Documentation/po/pot/*.pot files are updated from
   Documentation/*.txt by the i18n coordinator.  The translators are asked
   to update their translation when this happens.

 - A translator gets update to Documentation/po/pot/*.pot, performsn
   msgmerge^Wpo4a-updatepo to update Documentaiton/po/$(lang)/*.po and
   commits the fixed-up version.

You may want to help the i18n coordinator by supporting "make pot-update"
target in Documentation/po/Makefile to be run "from time to time".

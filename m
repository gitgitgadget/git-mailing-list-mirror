From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] http: expand http.cookieFile as a path
Date: Fri, 29 Apr 2016 10:55:00 -0700
Message-ID: <xmqq7ffgz4ej.fsf@gitster.mtv.corp.google.com>
References: <20160429062357.12647-1-computersforpeace@gmail.com>
	<20160429062357.12647-2-computersforpeace@gmail.com>
	<20160429141212.GB26643@sigill.intra.peff.net>
	<20160429155532.GA57118@google.com>
	<xmqqfuu4z4pr.fsf@gitster.mtv.corp.google.com>
	<20160429174958.GA30593@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Brian Norris <computersforpeace@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 19:55:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awCdF-00023a-LK
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 19:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339AbcD2RzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 13:55:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751169AbcD2RzH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 13:55:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 87FC417B71;
	Fri, 29 Apr 2016 13:55:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=slPbixMnTCOtIJTqqSXzie0QUHg=; b=HV/K9Y
	NFfIzxmP47ARs4wcOCudzSs+//fu+6lHaQS61WO2kBZXd2K+f/WmPuDXgnoT9+U8
	wy3VPWrwRFXeOr5SV9oifWDgFmzmxJwrbFALjP80R5XJNyAqs3R3I0YVFyA6twyT
	Laf/LxOX2waKcTKMrksEwW8Bq3XmJw3vDC2WM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jV296NTkWFrKAu6eu56hDMxHczgnjJwO
	n59Tpsgj84er2c5KQtm2gCpppPl4WFtCMqBeuFuPEz1oeY2gUgOgtJs5aia4NBpV
	SV5AupFhcHq2/UUZUPPhLbHwaO38GBFIMQpiBmiV+D5/pcMiD6tnIkQJH3Hnn3LW
	WtoNm2nTvvM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CC0417B70;
	Fri, 29 Apr 2016 13:55:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3F7C17B6B;
	Fri, 29 Apr 2016 13:55:02 -0400 (EDT)
In-Reply-To: <20160429174958.GA30593@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 29 Apr 2016 13:49:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FA215A4-0E33-11E6-8A04-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293037>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 29, 2016 at 10:48:16AM -0700, Junio C Hamano wrote:
>
>> Brian Norris <computersforpeace@gmail.com> writes:
>> 
>> > I mostly just copied from boilerplate on another option. IIRC, there
>> > were at least two other options that were documented similarly.
>> 
>> My quick grep didn't find 'another option' other than include.path,
>> but how about this as a preparatory step?
>
> I found core.excludesFile and commit.template which could use the same
> treatment.
>
> -Peff

Thanks.  Perhaps squash this to the patch in the message you are
responding to.

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ff7eaaf..786e0fa 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -603,11 +603,10 @@ be delta compressed, but larger binary media files won't be.
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 
 core.excludesFile::
-	In addition to '.gitignore' (per-directory) and
-	'.git/info/exclude', Git looks into this file for patterns
-	of files which are not meant to be tracked.  "`~/`" is expanded
-	to the value of `$HOME` and "`~user/`" to the specified user's
-	home directory. Its default value is $XDG_CONFIG_HOME/git/ignore.
+	Specifies the pathname to the file that contains patterns to
+	describe paths that are not meant to be tracked, in addition
+	to '.gitignore' (per-directory) and '.git/info/exclude'.
+	Defaults to $XDG_CONFIG_HOME/git/ignore.
 	If $XDG_CONFIG_HOME is either not set or empty, $HOME/.config/git/ignore
 	is used instead. See linkgit:gitignore[5].
 
@@ -1116,9 +1115,8 @@ commit.status::
 	message.  Defaults to true.
 
 commit.template::
-	Specify a file to use as the template for new commit messages.
-	"`~/`" is expanded to the value of `$HOME` and "`~user/`" to the
-	specified user's home directory.
+	Specify the pathname of a file to use as the template for
+	new commit messages.
 
 credential.helper::
 	Specify an external helper to be called when a username or

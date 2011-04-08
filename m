From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] magic pathspec: add tentative
 ":/path/from/top/level" pathspec support
Date: Fri, 08 Apr 2011 09:37:24 -0700
Message-ID: <7vpqow4s3f.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-2-git-send-email-gitster@pobox.com>
 <BANLkTint7sGCg7_seu1-SWJC=_sKF-FKYw@mail.gmail.com>
 <7vd3kyf327.fsf@alter.siamese.dyndns.org>
 <BANLkTi=YK-4TOxoD1qR8TO4SymLK6sPnQA@mail.gmail.com>
 <7vtye84wc3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 18:37:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8Egk-0004Z3-TJ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 18:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757586Ab1DHQhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 12:37:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757035Ab1DHQhd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 12:37:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9400D338D;
	Fri,  8 Apr 2011 12:39:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eXh9ilixeOOMP+35mJvwibgOZz0=; b=J1y6mL
	r/pzO0up5sSHo/CxcRx7j88+oPtJ5p0NmRpN1699kEvJD3hazt8saF3Xkk5ggcyU
	LygNuc7PezAkAGhbvllrgc1oSa0u1Jo4Gfp2Faw9AYPplIgKVKR4n3rXAGWxipJG
	wIqxukgjcTJbBpcfk1PbVrsDvAgHKbJxwT5rE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cj2Xpv5S+bwJ7VYR0T5W9feYPushMXvy
	V60GVUozM4+hGB7Vmir0JGjdl9nE6D4w0MpsodXqbaguKvxKq65mY926+uAshMRv
	2NS4byLXEnQXjNQgyJiPjHz9B8+H/exMDvr3zry8UbcqSwf2+fGJEApWUfLDZUO4
	jLHr9eVSERY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 72D59338A;
	Fri,  8 Apr 2011 12:39:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 712D63372; Fri,  8 Apr 2011
 12:39:22 -0400 (EDT)
In-Reply-To: <7vtye84wc3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 08 Apr 2011 08:05:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3B17B0E-61FE-11E0-8F58-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171135>

Junio C Hamano <gitster@pobox.com> writes:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> On Thu, Apr 7, 2011 at 11:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> This is so that you can say ":/.gitignore" and do not have to say
>>> ":/:.gitignore".
>>
>> But then, say people have a file named @foo at top dir. They can write
>> ":/@foo" to address the file. Some time later we decide to use '@' as
>> magic, how can we re-train user's fingers?
>
> You don't.  The primary goal of short form is to be short to type from the
> command line, and if you are in doubt, you can always disambiguate by
> saying ":/:@foo", and you can use the terminating colon even if you are
> sure "@" is not a magic in your version of git.

Actually, after thinking a bit more about it, I changed my mind.

It is not such a big deal to require the terminating colon for a pathname
that begins with a nonalnum (except for '.' and we might find some others
perhaps '_'), as they are rare.

I agree that we should reserve most of the nonalnum ASCII as potential
magic, and require the terminating colon if the user wants to start the
pattern part with a potential magic signature letter and error out if we
see a magic that we do not support yet.  The reason I said "most of" is
that we should exclude some non-alnum letters that often begin a filename.

Off the top of my head, we should exclude "." (period -- dot-files are
common), "_" (underscore), and possibly "+" (plus) and "=" (equal), as I
saw these used to start filenames, but the latter two are rather rare and
I don't mind requiring the terminating colon after the magic signature.

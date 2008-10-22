From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: don't escape tilde ('~') for http(s) URLs
Date: Tue, 21 Oct 2008 23:24:44 -0700
Message-ID: <7vskqpuoyb.fsf@gitster.siamese.dyndns.org>
References: <20081018213919.GC3107@atjola.homenet>
 <20081018224728.GD3107@atjola.homenet>
 <20081021211131.GA21606@yp-box.dyndns.org>
 <7vtzb5wr6v.fsf@gitster.siamese.dyndns.org>
 <20081022061325.GC8225@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	git@vger.kernel.org, jsogo@debian.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Oct 22 08:26:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsXAV-0007F0-MB
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 08:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYJVGY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 02:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753444AbYJVGY6
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 02:24:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44935 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbYJVGY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 02:24:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 125038ED49;
	Wed, 22 Oct 2008 02:24:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 968288ED48; Wed, 22 Oct 2008 02:24:47 -0400 (EDT)
In-Reply-To: <20081022061325.GC8225@glandium.org> (Mike Hommey's message of
 "Wed, 22 Oct 2008 08:13:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 24E97B7C-A002-11DD-9FFB-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98833>

Mike Hommey <mh@glandium.org> writes:

> On Tue, Oct 21, 2008 at 02:53:28PM -0700, Junio C Hamano wrote:
>
>> >> For svn we have:
>> >> write(5, "<S:update-report send-all=\"true\" xmlns:S=\"svn:\">
>> >> <S:src-path>https://sucs.org/~welshbyte/svn/backuptool/trunk</S:src-path>...
>> >>
>> >> While git-svn shows:
>> >> write(7, "<S:update-report send-all=\"true\" xmlns:S=\"svn:\">
>> >> <S:src-path>https://sucs.org/%7Ewelshbyte/svn/backuptool/trunk</S:src-path>...
>> 
>> This looks like an XML based request sequence to me (and svn is talking
>> WebDAV here, right?);
>
> XML based would be &126;, not %7E.

Read what you quoted again and realize you are agreeing with me ;-).

The former (with "~") is what svn expects, the latter (with %7E) is what
git-svn incorrectly threw at the server causing problems.  I am wondering
the whole %xx escaping thing, which does not seem to match what svn seems
to expect.

> Anyways, aren't there ready-to-use url quoting functions in perl ?

My question is not about correct "url quoting", but if using "url quoting"
is correct in this context.

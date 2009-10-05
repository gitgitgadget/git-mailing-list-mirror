From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add the --submodule-summary option to the diff option
   family
Date: Mon, 05 Oct 2009 08:18:48 +0200
Message-ID: <4AC98FC8.3090202@viscovery.net>
References: <cover.1254668669u.git.johannes.schindelin@gmx.de> <67a884457aeaead275612be10902a80726b2a7db.1254668669u.git.johannes.schindelin@gmx.de> <7vbpkmn6oi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:20:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mugvu-0000fc-IW
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 08:20:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392AbZJEGTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 02:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbZJEGTd
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 02:19:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:57318 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751097AbZJEGTc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 02:19:32 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MuguH-0001xs-39; Mon, 05 Oct 2009 08:18:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C5AFCBC81; Mon,  5 Oct 2009 08:18:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vbpkmn6oi.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129531>

Junio C Hamano schrieb:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> +	fwrite(sb.buf, sb.len, 1, f);
>> +
>> +	if (!message) {
>> +		while ((commit = get_revision(&rev))) {
>> +			strbuf_setlen(&sb, 0);
>> +			if (del)
>> +				strbuf_addstr(&sb, commit->object.flags &
>> +						SYMMETRIC_LEFT ? del : add);
>> +			format_commit_message(commit, format, &sb,
>> +					rev.date_mode);
>> +			if (del)
>> +				strbuf_addstr(&sb, reset);
> 
>  - In the "ANSI-terminal only" world view, adding colors to strbuf and
>    writing it out together with the actual strings is an easy thing to do.
>    Don't Windows folks have trouble converting this kind of code to their
>    color control call that is separate from writing strings out?  If it is
>    not a problem, I do not have any objection to it, but otherwise I'd
>    suggest not to add any more code that stores color escape sequence in
>    strbuf, so that we would not make later conversion by Windows folks
>    harder than necessary.

Thanks for noticing this! To store color escapes in strbuf is not a
problem as long as the string is finally written using printf, fprintf, or
fputs.

>> +			strbuf_addch(&sb, '\n');
>> +			fwrite(sb.buf, sb.len, 1, f);

Outch! fwrite doesn't interpret color escapes. AFAICS, this sequence is
easy to change such that it uses fprintf().

-- Hannes

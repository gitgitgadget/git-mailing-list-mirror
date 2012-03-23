From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] difftool: print list of valid tools with '--tool-help'
Date: Fri, 23 Mar 2012 12:48:43 -0700
Message-ID: <7vzkb7rtd0.fsf@alter.siamese.dyndns.org>
References: <1331850311-4620-1-git-send-email-tim.henigan@gmail.com>
 <7v8vj1ihcn.fsf@alter.siamese.dyndns.org>
 <CAFouethYEmY7g3Uw0HfFMOKFNcBv=TyAsSyEkBU-cQrhaf6v7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 20:49:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBATp-0001Yu-5a
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 20:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757250Ab2CWTsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 15:48:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40474 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754858Ab2CWTsq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 15:48:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 903916392;
	Fri, 23 Mar 2012 15:48:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aEjfzVJzY4tAAWmMnFyYkVVw0l0=; b=DHpJ1I
	D/KqrDucG0boc3MyFmWLFDgRLxf6WlW5+N3pZFicyzAhZ2pPuAEBqGS+FOV/QDSg
	3k7/E21o5be+mHrLL9wEfSvKrb0Ho/AtVubeMn3+MdIe1kUQ/JlSTfKUqvzh2yfb
	wth4ibc+KzP612orGhxFmuMcD56fnu4w9N120=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xdme/7z8bj6+nzyIasuG7T1j5kNhebjL
	JtWhrJGNg65GS+FvjvUFzjqyqQTnugJXOtAYG7bI9HeWxlyCHypXcP6TKqF/GfwN
	whf9b8dgUB6PbEb7awTsCvvCuojPT6X8VOvHsu1cUbvjIe/6pNeCvyb/o/HmO9PL
	Ifp06/VIHC8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8074D6391;
	Fri, 23 Mar 2012 15:48:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC171638F; Fri, 23 Mar 2012
 15:48:44 -0400 (EDT)
In-Reply-To: <CAFouethYEmY7g3Uw0HfFMOKFNcBv=TyAsSyEkBU-cQrhaf6v7g@mail.gmail.com> (Tim
 Henigan's message of "Fri, 23 Mar 2012 14:26:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3313B88C-7521-11E1-8F9D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193798>

Tim Henigan <tim.henigan@gmail.com> writes:

> Rather than create a new entry point, I used the existing
> 'get_merge_tool_path' that resides in 'git-mergetool--lib' to
> determine if a given tool is actually installed on the system.
>
> The '$DISPLAY' variable is lost in this implementation, but honestly I
> don't understand how it was intended to be used.
>
> Does this look useful?

Sounds like a better way to do it.

The point of checking DISPLAY in "cando" is to allow for a tool that
changes its behaviour when launched in terminal-only vs windowed
environment. For example, if somebody tries to spawn a tool that *only*
works in windowed environment (e.g. "kompare") in a terminal-only session,
it would fail, and the "cando" mechanism was designed to allow a tool
detect such a situation and excuse itself from the available tools list.

I think get_merge_tool_path could do the same thing (i.e. report "no
executable available to run this tool" when appropriate), so I do not
think you lost anything.

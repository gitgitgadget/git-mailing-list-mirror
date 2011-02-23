From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [1.8.0] Don't copy "submodule.<name>.update" to .git/config on submodule
 init
Date: Wed, 23 Feb 2011 20:54:53 +0100
Message-ID: <4D65660D.3040501@web.de>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org> <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 20:55:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsKnc-0001KV-WB
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932469Ab1BWTy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:54:56 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:47966 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617Ab1BWTyz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:54:55 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate02.web.de (Postfix) with ESMTP id 064FA1994EF06;
	Wed, 23 Feb 2011 20:54:54 +0100 (CET)
Received: from [93.240.119.189] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1PsKnV-0004uf-00; Wed, 23 Feb 2011 20:54:53 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/pWM9TnN9LzKGOBqaSOGmpUj2zLzr5V6THHCcU
	3DRj6EeeBfGzC/662vFDTc92wmGeqP7gfXO9U8zWyGu8jZsl6p
	wezHsSrin2MhnEfIP8NQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167719>

Proposal:

Stop copying the "submodule.<name>.update" entries into .git/config
on "git submodule init". The current behavior makes it impossible
for upstream to change defaults later, as this value can only be
altered through user intervention when it resides in .git/config.
This is a good thing when he chose to copy it there, but it doesn't
seem to make much sense doing it by default. When for example
upstream wants to provide a branch for hacking on an otherwise
ignored submodule, it cannot do that without the users intervention
right now.

This change also makes sense in preparation of recursive submodule
checkout, as that will be controlled by this option. Also notice
that the proposed behavior is already used for the "ignore" and
"fetchRecurseSubmodules" entries.

History:

I can't tell why that copy is done as I wasn't following the list
closely at the time this was implemented. Maybe someone else can
shed some light on that?

Risks:

Users could be surprised that upstream can change the value of the
"update" configuration when the submodule was initialized with a
git version >= 1.8.0.

Migration plan:

In 1.8.0 stop copying the "submodule.<name>.update" entries into
.git/config and add an option ("--update"?) to reactivate the old
behavior of "git submodule init" if the user wants that. Announce
both in the release notes of 1.8.0.

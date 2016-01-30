From: Moritz Neeb <lists@moritzneeb.de>
Subject: Replacing strbuf_getline_lf() by strbuf_getline() in wt-status.c
Date: Sat, 30 Jan 2016 15:30:46 +0100
Message-ID: <56ACC916.8020008@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 15:31:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPWYj-0005En-S5
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 15:31:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbcA3Oat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 09:30:49 -0500
Received: from moritzneeb.de ([78.47.1.106]:48230 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754213AbcA3Oas (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 09:30:48 -0500
Received: from [192.168.1.11] (x4db33e5e.dyn.telefonica.de [77.179.62.94])
	by moritzneeb.de (Postfix) with ESMTPSA id D896E1C02A
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 15:30:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1454164247;
	bh=41l5NjJaqvcHqD1M2ReFEqIoZZwSLaJq7iiT7PtTnRw=;
	h=From:Subject:To:Date:From;
	b=NrPYOtYYJTTeETCqw06c5o0X3SijiBInpHQNvAffy3DgD14o8zSWUIaVWuT9YjAz7
	 sdl4wTh32wyP3+wNF+dTNAhFfOYrFRNWbaQw5NFULIokRqMMI9NUhTE8xI4FywIX+K
	 vUJa+a4kJa+/hVQ9/uR8yRyJ65xYWWZHZHtilWPE=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285115>

Currently I am working on replacing strbuf_getline_lf() by
strbuf_getline() in places where the input is trimmed immediately after
reading, cf. $gmane/284104, "Notes on the remaining strbuf_getline_lf()
callers", 2nd point.

One instance I found was in wt-status.c. In read_rebase_todolist() the
lines are read, checked for a comment_line_char and then trimmed. I
wonder why the input is not trimmed before checking for this character?
Is it safe to replace strbuf_getline_lf() by strbuf_getline() anyway?

The only case I can imagine that could lead to unexpected behaviour then
would be when someone sets the comment_line_char to CR. How likely is that?

Why is the trim after checking for the comment char anyway? Should
something like "   # foobar" not be considered as comment?

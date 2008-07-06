From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/14] Build in merge
Date: Sun, 06 Jul 2008 12:39:33 -0700
Message-ID: <7v8wweer9m.fsf@gitster.siamese.dyndns.org>
References: <0cde1e7c930589364318b2d0344b345453e23586.1214918017.git.vmiklos@frugalware.org> <7vej67jt1e.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0807061433480.3486@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 06 21:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFa6F-00021P-2a
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 21:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbYGFTjp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 15:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751224AbYGFTjp
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 15:39:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60032 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbYGFTjp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 15:39:45 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D38A1BFBE;
	Sun,  6 Jul 2008 15:39:44 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3EBEC1BFB9; Sun,  6 Jul 2008 15:39:36 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0807061433480.3486@wbgn129.biozentrum.uni-wuerzburg.de>
 (Johannes Schindelin's message of "Sun, 6 Jul 2008 14:38:23 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 488C5928-4B93-11DD-91B8-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87547>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But given that you seem so sick and tired of string_list, and rather have 
> a code duplication, I will not argue to that end anymore.

You are probably very confused if you think I am saying I'd rather have
duplication.

Look at "unsorted_path_list_lookup()" in builtin-merge.c and think again.
Look at "path_list_append_strategy()" in builtin-merge.c and think again.

If you are adding the same amount of code _anyway_, why not write using
more appropriate data structure for the job?

The path_list has its uses.  It's wonderful when you have existing
structures that you would need to keep in core anyway and being able to
look them up via string keys.  But that does not mean it is (nor should be
"improved" to be) a good match for other forms of (ab)uses.

The way it was used by initializing with pointer to a static array
location is clearly a misuse.  When using ->util field to store things
other than pointers to preexisting structures, the use of the API becomes
clunky and we discussed this issue about another patch.  That's all I was
saying.

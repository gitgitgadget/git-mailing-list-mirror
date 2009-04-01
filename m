From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-clone.c: fix memory leak in cmd_clone()
Date: Wed, 01 Apr 2009 09:23:04 -0700
Message-ID: <7v3acs1gyf.fsf@gitster.siamese.dyndns.org>
References: <20090401144056.GC2237@lilem.mirepesht>
 <alpine.DEB.1.00.0904011754250.13502@intel-tinevez-2-302>
 <20090401161254.GD2237@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Ali Gholami Rudi <ali@rudi.ir>
X-From: git-owner@vger.kernel.org Wed Apr 01 18:25:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp3FP-0007xf-Tx
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 18:25:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763843AbZDAQXO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 12:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756397AbZDAQXN
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 12:23:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57491 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765362AbZDAQXM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 12:23:12 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C8B66A6308;
	Wed,  1 Apr 2009 12:23:10 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6974FA6306; Wed,
  1 Apr 2009 12:23:06 -0400 (EDT)
In-Reply-To: <20090401161254.GD2237@lilem.mirepesht> (Ali Gholami Rudi's
 message of "Wed, 1 Apr 2009 20:42:54 +0430")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 64590290-1ED9-11DE-94A9-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115401>

Ali Gholami Rudi <ali@rudi.ir> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> On Wed, 1 Apr 2009, Ali Gholami Rudi wrote:
>> 
>> > With this patch, cmd_clone() safely frees its xstrdup()-allocated
>> > memory.  Also junk_work_tree and junk_git_dir (used in remove_junk()
>> > which is called asynchronously) were changed to use static arrays rather
>> > than sharing the memory allocated in cmd_clone().
>> 
>> If you want to go down that route, you will have a long way to go: the 
>> assumption is pretty much in every cmd_() and main() function that 
>> singletons will be free()d automatically when the process ends.
>
> Well... I saw strbuf_release() calls in the end of cmd_clone() and had a
> quick look at a few other cmd_*() functions; it seems most of them (?)
> try to free their memory.  I thought it might make sense to do that for
> cmd_clone().  But you're right; they will be freed eventually.  (It
> seems like a minor leak which is respected only some of the times :-) )

Yup, I'll queue (I won't have time today to work on git it seems) the
other two patches from you, but I was going to drop this one---unless your
plan was to make cmd_clone() callable more than once in order to use it in
say a C rewrite of git submodule or something like that.

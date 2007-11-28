From: Geert Bosch <bosch@adacore.com>
Subject: Re: Rollback of git commands
Date: Tue, 27 Nov 2007 23:07:29 -0500
Message-ID: <3AAC5548-A9AC-4236-B1F7-5CFDE11B52C4@adacore.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com> <7vmyszb39s.fsf@gitster.siamese.dyndns.org> <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com> <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:26:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwb-0004gy-QJ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:19:05 +0100
Received: from mail-mx2.uio.no ([129.240.10.30])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxENV-0006gV-6j
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:18:25 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxENN-0003GA-9t
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:18:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbXK1EHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 23:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbXK1EHb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 23:07:31 -0500
Received: from rock.gnat.com ([205.232.38.15]:40288 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753233AbXK1EHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 23:07:31 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 2C5DF2A965B;
	Tue, 27 Nov 2007 23:07:30 -0500 (EST)
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OrvWfrxZuihb; Tue, 27 Nov 2007 23:07:30 -0500 (EST)
Received: from [172.16.1.99] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTP id D5B5F2A9657;
	Tue, 27 Nov 2007 23:07:29 -0500 (EST)
In-Reply-To: <9e4733910711271749q1b96bfe9i60e43619c89234b9@mail.gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 97BC20CE729D59655C2CE0DFF2A8B29CB3FD7792
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 19 total 723786 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66300>

On Nov 27, 2007, at 20:49, Jon Smirl wrote:
> Rollback is too strong of name for this. Checkpoints would be better.
> The idea is to record the total system state at convenient moments and
> then allow moving back to the checkpointed state. The object store
> supports this, but the rest of the state in .git/* isn't being
> recorded.

I have always wondered why refs and tags are not
in the regular object store. In a way, there
should be just one root pointer (SHA1) pointing
to a tree with refs, etc.

As for the problem of "lots of loose objects", each
command could write a single pack file. By directly
writing deltas instead of complete new tree objects,
storage requirements should be modest. Also, just
writing a single new pack file is very efficient
for I/O purposes.

To prevent too many pack files, a merge policy
could allow a new pack to include (and thus obsolete)
a number of similarly sized or smaller packs.
After the new file has been successfully written, the
old files are no longer necessary and can be
moved to a "trashes" area to be expired.

   -Geert

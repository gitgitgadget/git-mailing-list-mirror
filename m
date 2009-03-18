From: "Marcel M. Cary" <marcel@oak.homeunix.org>
Subject: Re: Ability to edit message from git rebase --interactive.
Date: Wed, 18 Mar 2009 07:52:07 -0700
Message-ID: <49C10A97.6060201@oak.homeunix.org>
References: <200903171953.23650.ogoffart@kde.org>	 <alpine.DEB.1.00.0903172329480.10279@pacific.mpi-cbg.de>	 <20090318004056.GB25454@coredump.intra.peff.net>	 <7vsklbod0l.fsf@gitster.siamese.dyndns.org> <fabb9a1e0903172242v6f67aa9er40fe0ae2a2db7bc3@mail.gmail.com> <49C0C4C5.5070802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Goffart <ogoffart@kde.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 18 15:53:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljx9S-0002kE-OA
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 15:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbZCROwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 10:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbZCROwU
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 10:52:20 -0400
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:27689 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751644AbZCROwT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Mar 2009 10:52:19 -0400
Received: (qmail 95957 invoked from network); 18 Mar 2009 14:52:17 -0000
Received: from unknown (HELO ordinateur.home.org) (marcel@76.240.231.157 with plain)
  by smtp126.sbc.mail.sp1.yahoo.com with SMTP; 18 Mar 2009 14:52:17 -0000
X-YMail-OSG: 2bFFUeIVM1mOezsqtDIW9T_9EWdkh9vhHDzVFPd9.wVpxW9O7U683jNpNUf7oVgBF4LTE65w98Me5l1ZUMTf87vTL07ricFt3U5urdASfDkyyWvKCRkYGypSEPljoW3oXWQzSi9P96ZoDqsDpnodwiCksxFGT1BmyOilpxUkXc7anwS6uEZxOnAfeQ--
X-Yahoo-Newman-Property: ymail-3
Received: from polliwog.home.org ([192.168.0.18])
	by ordinateur.home.org with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <marcel@oak.homeunix.org>)
	id 1Ljx7w-0004lJ-12; Wed, 18 Mar 2009 07:52:16 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20070801)
In-Reply-To: <49C0C4C5.5070802@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113618>

Michael J Gruber wrote:
> Sverre Rabbelier venit, vidit, dixit 18.03.2009 06:42:
>> Heya,
>>
>> On Wed, Mar 18, 2009 at 02:06, Junio C Hamano <gitster@pobox.com> wrote:
>>> Jeff King <peff@peff.net> writes:
>>> I am not quite sure what rephrase is buying us.  Do we also want to
>>> introduce retree that allows you to muck with the tree object recorded
>>> without giving you a chance to clobber the commit log message?
>> Is that a common operation? Rephrase is, at least to me...
>>
> 
> Rephrase for sure is common, and for sure can be done currently... It's
> only that "commit --amend, save&quit, continue" could be shortened.
> 
> OTOH: Most commonly one would want to rephrase a commit message or two
> without actually rebasing anything. And the proposed change doesn't help
> as much as it could, in two respects:
> 
> 1) I want to be able to say "rephrase HEAD~2" without having to edit a
> rebase action script. (That would be useful for rewriting a single
> commit as well, and could be added easily.)
> 
> 2) Currently, all rebasing operations have trouble with merges. But if
> all I want to do is rephrasing a log message then no diff/apply is
> necessary, no rewriting of trees, no change in the DAG structure (i.e.
> connectivity; sha1s change, of course). So there should be a special
> mode for DAG-preserving rewrites, where one can be sure that merges are
> fully preserved.
> 
> 2) seems to be the most important point to make rephrasing safe and
> convenient.

Interesting points about skipping the action script and preserving
structure.  I just tried to do something like that with filter-branch:

git filter-branch --msg-filter 'cat > tmp;  $EDITOR tmp < '$(tty)' >
'$(tty)' 2>&1; cat tmp' ^HEAD^ HEAD

And discovered that it will neither accept "HEAD^^..HEAD^" nor "HEAD^"
as a shortcut for a rev-list containing a single commit.  But if you're
content to save and quit each message through the branch tip and specify
the range, it seems to work.

I have no idea what it would take to make filter-branch support the
additional kinds of rev and rev list specifications, or if that would be
undesirable.

I'm assuming it accomplishes (2) because of the nature of filter-branch.

Marcel

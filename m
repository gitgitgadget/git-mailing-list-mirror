From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5 3/3] gitweb: gravatar url cache
Date: Wed, 24 Jun 2009 17:01:43 -0700
Message-ID: <7vvdmlnpug.fsf@alter.siamese.dyndns.org>
References: <1245878183-2967-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1245878183-2967-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1245878183-2967-3-git-send-email-giuseppe.bilotta@gmail.com>
	<1245878183-2967-4-git-send-email-giuseppe.bilotta@gmail.com>
	<7v63elqoig.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0906241546x6b6164e7w4e6c6601d1119032@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Aaron Crane <git@aaroncrane.co.uk>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 02:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJcQW-0003nl-LE
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 02:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010AbZFYABm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 20:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755138AbZFYABm
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 20:01:42 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:50565 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754685AbZFYABl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 20:01:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090625000143.UHYT20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 24 Jun 2009 20:01:43 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 801k1c0034aMwMQ0401kQV; Wed, 24 Jun 2009 20:01:44 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=TPKOCYBqXYMA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=f6JMW6W5C5hBNHQ4eIIA:9 a=vfCJ45aHZ_SnjSKlI6EA:7
 a=bxMFX_tJtRy3EBWl0RgxvGx7uN0A:4 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
 a=b-eymacw3xNTbp4F:21 a=wQ3AYE2Fq0bvnZy0:21
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0906241546x6b6164e7w4e6c6601d1119032@mail.gmail.com> (Giuseppe Bilotta's message of "Thu\, 25 Jun 2009 00\:46\:22 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122170>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Thu, Jun 25, 2009 at 12:02 AM, Junio C Hamano<gitster@pobox.com> wrote:
>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>
>>> Views which contain many occurrences of the same email address (e.g.
>>> shortlog view) benefit from not having to recalculate the MD5 of the
>>> email address every time.
>>> ---
>>
>> Sign-off?
>
> Duh.
>
>> I think the cache is placed at the wrong level (it doesn't have to be a
>> GRavatar_url_cache, but can be a general avatar_url_cache).
>
> I'm not sure about it. The URL depends on email and size (can you use
> arrays as hash keys in Perl?) , and the email part might be the same
> but the size part might differ across separate calls (in theory; in
> practice avatars in a view are presently all the same size; but for
> example if we were to autodetect email addresses in commit messages,
> we might have both single- and double- sided avatars in the same
> page). By hashing on email+size only we would lose the benefit of
> cache when using the same avatar at separate sizes.

You can use nested hash, like:

	$avatar_cache{$email}{$size}

or

	$avatar_cache{$size}{$email}

but that is completely orthogonal to the issue of using a single cache
shared across services, isn't it?

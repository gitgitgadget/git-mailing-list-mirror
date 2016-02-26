From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH 14/16] bisect: use a modified breadth-first search to find
 relevant weights
Date: Fri, 26 Feb 2016 21:55:16 +0100
Message-ID: <56D0BBB4.9020305@gmx.net>
References: <1456452282-10325-1-git-send-email-s-beyer@gmx.net>
 <1456452282-10325-15-git-send-email-s-beyer@gmx.net>
 <xmqqr3g0kvzx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 21:55:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZPQU-0006sy-EA
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 21:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932066AbcBZUzp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 15:55:45 -0500
Received: from mout.gmx.net ([212.227.17.21]:51532 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754972AbcBZUzo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 15:55:44 -0500
Received: from [192.168.178.43] ([188.108.247.176]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0Ma2Lr-1aLzph2QjH-00LodP; Fri, 26 Feb 2016 21:55:26
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.5.0
In-Reply-To: <xmqqr3g0kvzx.fsf@gitster.mtv.corp.google.com>
X-Provags-ID: V03:K0:6k5YQRWyX7waQ3H0P6DDb6O05jTGTGTcamgZenTUPUCvkuWuqpP
 uWQnYURd8cqmslTnVAXeOENGhARz4QWr4HzPs9ysFs/pWrSv+rKOT3KWuCZ71SfZnXjj2AV
 /vRcZQ5R89ffix/NgymiS1rNL2turLKqmlcAizIV/i6ECzg2+DZXoyCAy/DskKcCg8/HQfG
 vxg/Qxz0RXdV0zo3+UjeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HDIQoSasy/8=:Rx9ISYaLLKuYSB9v87W94G
 SqIeY3I5thgyl6GGd643MjcTmnXjRbbrqR+oURoS4G6XnGcMiZFJhtpbJyBKZX/UVOz+br3cU
 nmteGrdvnCsUI6d6kG42qRr7YJ8Xekys41Hz0wxKczs+qf/qvyGcCC82cbXc466UkUjjrylzq
 ORbNeodDxPhdIZqA6IrrkPvFE6P+AeMwQAGH2vXmPta19l0BCfsy0Xhw53cgZUm2LnofX/FAp
 2b0LpnkxtE4T6oQFBegQOJKrlkgx0uVIg37KUMeVpJIJQvEggZtEoXNaKqdzZH54a7IUZhP15
 RqBTjcmt8pXMDIeB85SC68xVJIyV4suiwXyE7MwUUZFxdEoJ5RIQ9MyOy5tjzEUZwot+xK9ip
 m6k9+t4IheTdXbKCf5H3RHO/C9Kzz2IAPtBcpiV3wAd1sp1RbGt5EivNhkzrh/UBFMpYk/HNq
 meaJwCdyWcJocsxuVRHorjPisCgOFUMIs1CEOqblHv7x9Ve+AHQNg+dRKvp/FU9udSCjw6hef
 nt1H7RQuDVVXRWDqDxM4C42wggA0DnBIcyjZxkrTqbIjxdnZzxO9jVHh+734s8CxWfan6IB1M
 SvAcqMXo8GkbjRkfzdfy9VkrOsnmFdbNj7MvuCgSciGH/g0xwtSeu5hzbh9NPLQoMZ909CPtE
 9hZXKWfnNHvga39bhv03uFxBzZzfVyQxw2ExKxPiqCLvjczukGsUEWLL2a9PJNC/qApdYVgW9
 coui3EjVyullI9z5kQI28tasFPNygQn3dvyn9gPAcvWYlRwn/kUMtirMpbLJvRtX+mZcf7RW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287622>

Hi,

On 02/26/2016 04:09 AM, Junio C Hamano wrote:
> Interesting.  So you walk from the bottom commits, incrementing the
> weight while walking on a part of the graph that is single strand of
> pearls, or doing the "count the reachable ones the hard way" when
> you hit a merge [*1*], but either way, once you know the commit you
> are looking at is above the mid-way, i.e. reaches more than half of
> the graph, then stop walking because its children will never be
> better than that commit?

Exactly. Maybe that's an even better description for the commit message l-)

> I haven't studied the code carefully, but your mention of BFS makes
> me wonder if you can "narrow" down the search space even more.

I had an idea that aimed at accomplishing this by finding the
highest-distance merge commit using binary search. (The BFS collected
all merge commits, in that order, then you could do binary search.)
So you have O(log(#mergecommits)) "do it the hard way" weight computations.
However, in the worst case (or even in every case, I did not thoroughly
think about the cases that can occur), it could happen that it also had
to do these "do it the hard way" computations for all merge commits with
smaller weight... That's why I dropped this idea in favor of the more
simple approach that I sent to the list.

> In an earlier step of the series, you introduced a work queue to
> replace the recursion.  The recursion forces the algorithm to work
> along the topology of the history, but you have more latitude in
> selecting the commit to dig further with a work queue.
> 
> I wonder if you can sort the elements on the work queue based on
> their distance (i.e. by using a priority queue).  You know the total
> upfront, so you may find a commit whose weight is exactly half of it
> before traversing all the bottom half of the history and it may turn
> out to be even more efficient.  After all, you are only looking for
> just one such commit, not trying to find all the commits with the
> best weight.

For the compute_weight() function (the "doing it the hard way"
function), this would not make sense since all parent commits (of a
merge commit we call compute_weight() on) will have smaller distance.

However, your idea can help:
I just noticed that it's not important that I use a *B*FS because of the
acyclity. So I could also use a DFS that is "more greedy" going towards
high numbers.
Note that the traversal is always on trees because the merge commits are
cut out. So whenever a branching (a commit with more than one child)
occurs, the DFS should follow the branch of maximum length to its leaf.
(These maximum lengths can be saved during build_reversed_dag().)
Then, if there is a halfway commit, we stop. If not, we can just go on
with the remaining DFS...
I think I only rethought and rephrased your idea. :) Sounds good to me.
I'm going to add commits for that.

> [Footnote]
> 
> *1* A merge between a commit that reaches N commits and another that
> reaches M commits may have weight smaller than the sum of N and M,
> and that is why I left the original "truly stupid algorithm" Linus
> wrote as-is when I did the obvious optimization for the linear parts
> of the history.

Yes. In fact, the "truly stupid algorithm" is not truly stupid. I'm not
quite sure, but I think it's still the best algorithm known so far for
that problem. (But maybe the problem is just not very interesting in
science.)

> *2* Whenever I revisited the bisection in my head, I thought about
> ways to improve that "truly stupid" counting, but never thought
> about an approach to simply reduce the number of times the "truly
> stupid" counting has to be done.

Well, I also improved that "truly stupid" counting a little in a former
commit (patch 7). But it's just the implementation that I improved
(time/memory trade-off), not the algorithm. :)

Cheers,
  Stephan

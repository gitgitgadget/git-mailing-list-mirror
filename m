From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Question about 'branch -d' safety
Date: Sat, 17 Jul 2010 19:43:47 -0500
Message-ID: <20100718004347.GA8665@burratino>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain>
 <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com>
 <20100711133730.GA10338@localhost>
 <20100717093006.GA11452@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Jul 18 02:45:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaI08-0004ga-OF
	for gcvg-git-2@lo.gmane.org; Sun, 18 Jul 2010 02:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab0GRAot convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 20:44:49 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64373 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753092Ab0GRAos (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jul 2010 20:44:48 -0400
Received: by iwn7 with SMTP id 7so3375267iwn.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 17:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hcbCEpthJ4ykjoBawl7p4aHHHDwbXGwZjDPEYPLvkrw=;
        b=CpRXd0pYjwY3euiKKKP004MvP26XqBOrG6PoaRliqOkXBUG8DrPKeScjKW+9AWbgBa
         6zCBtkJAlDU/ECsCPULmUWEb7kM9gx+rywXxn+ZDVkN1Gk4XQnltwgZi/bf1sVwMou8m
         XEgzbGN81jGcg+eprNTqxNv5tD8dlMtlgXLAg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=iHpN1rdUYM9XbhWPpCJNj1ME3v4V78XLGCkiKVJrIYirGYZLclbZQ+DNG25f6+fAf/
         +iHi7FAJkUP/SIz4uWrG0bkPK/KDUwGp7Gc2N+EIn/Y2onqCXVub7fC/nFFtTmjd9Gfk
         4f3KQnWdGak2FrF0Aft/zyhyixIc4SC8tq6bY=
Received: by 10.231.158.203 with SMTP id g11mr3289486ibx.24.1279413886833;
        Sat, 17 Jul 2010 17:44:46 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id n20sm17237326ibe.17.2010.07.17.17.44.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 17 Jul 2010 17:44:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100717093006.GA11452@localhost>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151200>

Clemens Buchacher wrote:

> I am not sure how to proceed with this.

Maybe: try out the patch locally for a while.  Such an experiment
would make it easier to see whether this feature because indispensible
and how the details should be to work best in practice.

But be careful!  Once you have learned to rely on the
master@{before.deletion} facility, you might end up trigger-happy with
=E2=80=98branch -d=E2=80=99 and get into trouble when faced with copies=
 of git without
the safety valve.

To respond to your philosophical points:

> + safety net

I consider it very good that git is willing to _lose_ information
rather than get overloaded with it.  On this laptop, if I try

 linux$ git fetch git://git.kernel.org/pub/scm/linux/kernel/git/sfr/lin=
ux-next.git
 linux$ git checkout FETCH_HEAD
        ... hack away ...

in a repository with quickly-expiring HEAD reflog, then the pack size
stays barely comfortable.  Perhaps a person that regularly builds
short-lived topic branches off such an unstable branch would be
similarly grateful that the objects do not need to stay long.

So: this aspect is a minus for me.

> + less dependant on git branch -d

I have not find =E2=80=9Clog -g=E2=80=9D too useful for protection agai=
nst fat-finger
accidents (=E2=80=9Cfsck --lost-found=E2=80=9D and =E2=80=9Cpush=E2=80=9D=
 take care of that) so it
seems odd to see safety touted as its main benefit.  What the reflog
and HEAD@{4} syntax prevent me from losing is a train of thought.
After deleting a branch I have just merged, if I start to wonder about
=E2=80=9Cthat branch I just deleted=E2=80=9D, reading reflog entries to=
 find it
is the last thing I want to be doing.

In other words, it is not enough that =E2=80=9Cbranch -d=E2=80=9D be sa=
fe.  Yes, the
old branch tip is an ancestor of origin/master, but that does not
bring me much closer to finding it.  To be able to refer to
master@{5.minutes.ago} directly would be much more convenient.

+.

> + automatically prune remote tracking branches

I=E2=80=99m not comfortable with the idea yet.

0.

> - only a convenience
> - implementation complexity

Your implementation seemed simple.  I don=E2=80=99t think implementatio=
n
complexity is the fatal flaw.

0.

> - user interface complexity

Keeping the reflog would arguably make the syntax for specifying
revisions more consistent.

On the other hand, there are some hard policy questions:

 * Should pre-deletion commits expire more quickly?

 * What happens when you rename one branch to take on the
   name of a deleted one?

 * What happens when you create a new branch to take the
   place of a deleted one?

 * Should refs outside the refs/heads/ namespace
   (like refs/bisect/ and refs/original/) use the same
   policy as refs/heads/?

0.

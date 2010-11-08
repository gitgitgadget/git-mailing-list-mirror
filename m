From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC] Using gitrevisions :/search style with other operators
Date: Mon, 8 Nov 2010 14:11:54 -0800
Message-ID: <4F75AA0C-B68A-4ABB-B67A-D7F62D989655@sb.org>
References: <9D675671-693D-4B59-AF2A-0EFE4C537362@sb.org> <7vpqufpr7f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 08 23:12:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFZwa-00060m-F1
	for gcvg-git-2@lo.gmane.org; Mon, 08 Nov 2010 23:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab0KHWL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Nov 2010 17:11:58 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56270 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755318Ab0KHWL5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Nov 2010 17:11:57 -0500
Received: by pwj1 with SMTP id 1so96315pwj.19
        for <git@vger.kernel.org>; Mon, 08 Nov 2010 14:11:57 -0800 (PST)
Received: by 10.142.47.2 with SMTP id u2mr5334221wfu.68.1289254317283;
        Mon, 08 Nov 2010 14:11:57 -0800 (PST)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id x18sm498299wfa.23.2010.11.08.14.11.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Nov 2010 14:11:56 -0800 (PST)
In-Reply-To: <7vpqufpr7f.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160996>

On Nov 8, 2010, at 11:09 AM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> There is one operator that doesn't allow this at all, and that's the commit
>> message search (e.g. :/foo). Every character after the :/ is taken to be
>> part of the regular expression. This is rather unfortunate as it prevents me
>> from doing something like :/foo^ to refer to the parent of the matching commit.
>> 
>> Does anybody have any opinions on changing this operator?
> 
> If you mean to change what ":/Merge branch 'kb/blame-author-email'" means,
> and make my scripts suddenly start breaking, I would be moderately unhappy.

Ah yes, I suppose you do have a common case it would break.

> It is fine if we can enhance the extended SHA-1 vocabulary by introducing
> a syntax that used to be illegal, hence there is no chance somebody was
> using it for other purposes.
> 
> I wonder if we can introduce something like ':( ... )' to group things.
> E.g.
> 
>    $ git log 'HEAD..:( :/Merge branch 'kb/blame-author-email' )^2'
> 
> I haven't visited the particular codepath for some time, so I don't know
> offhand how involved the change would be, though.

Interesting idea. It certainly solves the problem of being able to embed it
within other operations (though you do then have to worry about escaping any
embedded close-parens in the search), though it does mean my suggestion for
being able to select the 2nd (or nth) match won't work. When I have the time
I'll start taking a look at the code.

Any comments on my suggestion to specify the ref to search from, e.g.
origin/pu:/"Merge 'kb/blame-author-email'"? As I stated before, I believe
this syntax is currently-unused (as it is interpreted as a file lookup, but
file paths starting with / will never resolve to anything in testing),
but I want to make sure I'm not overlooking something.

-Kevin Ballard
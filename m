From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/8] cherry-pick: treat CHERRY_PICK_HEAD and REVERT_HEAD as refs
Date: Wed, 08 Jul 2015 16:23:36 -0700
Message-ID: <xmqq4mlexmh3.fsf@gitster.dls.corp.google.com>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com>
	<1436316963-25520-2-git-send-email-dturner@twopensource.com>
	<559D6208.8090607@kdbg.org> <1436382962.4542.8.camel@twopensource.com>
	<559D92CF.7000408@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jul 09 01:23:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCygr-0000nf-Mb
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jul 2015 01:23:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbbGHXXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 19:23:41 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35832 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbbGHXXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 19:23:39 -0400
Received: by igcqs7 with SMTP id qs7so67945282igc.0
        for <git@vger.kernel.org>; Wed, 08 Jul 2015 16:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=DY3NNbkZ882wMG5VlNVL+nHMUZ8udHUUqsWiUmQ8NX4=;
        b=OijzfQW8cFzRusAhwM6EvUnMwUht4vCWKiKdUXQZNFqjO8YhvyRQiL79iwQm4DqWVz
         P+pQunJQ7emlWs1lMv6DlEXt4qRSOAj7Sa5CjxausnZnOeh3ePQEG55lljH15rJKA9Bs
         okMgMc+WDelSfGcosULclZnQNKol7nisfBoj99l0JigwpYgx+DPGuayTLAbbw69GYzVx
         jsmgq2pzJPPwkCvKf5Zt42f3PXxmpCqZMfY9KSaEEEYGVrIchx0xVhVA5zMSjwqcMv5b
         ivxVLi32X1WzQspUGNgSme8+6iUe+rN0NA4lTnwN6vFzvf4qD+LKWe2jIauWU5Z7UeaL
         RY/g==
X-Received: by 10.107.32.73 with SMTP id g70mr22010538iog.23.1436397818607;
        Wed, 08 Jul 2015 16:23:38 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6567:f006:f2bd:2568])
        by smtp.gmail.com with ESMTPSA id g1sm2911146iog.4.2015.07.08.16.23.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Jul 2015 16:23:37 -0700 (PDT)
In-Reply-To: <559D92CF.7000408@kdbg.org> (Johannes Sixt's message of "Wed, 08
	Jul 2015 23:14:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273717>

Johannes Sixt <j6t@kdbg.org> writes:

>> We could reduce the number from two to one by providing a new
>> git-am-status command which outputs one of "CHERRY-PICKING",
>> "REVERTING", or "" (or maybe it would also handle rebase and am).  We
>> could also generalize it to "git-prompt-helper" or something by moving
>> that entire bunch of if statements inside.  This would replace calls to
>> "git describe".
>>
>> But you probably have a better idea.
>
> Isn't it mere coincidence that the content of these two files looks
> like a non-packed ref? Wouldn't it be better to consider the two akin
> to MERGE_HEAD (which is not a ref because it records more than just a
> commit name)?

That is an excellent thought that seems to have escaped everybody
involved in the review.

These things do not behave like refs.  They do not want reflogs (and
even if they had, the log would not mean much), and if we want to
add more information on the cherry-pick and revert in progress, they
are the most natural place to do so.

Another thing that makes me vote for treating them just like
FETCH_HEAD, MERGE_HEAD and other ALL_CAPS files like COMMIT_MSG is
what should happen in a repository with more than one working trees.
You do not want to share what "CHERRY_PICK_HEAD" means across them
only because they happen to record an object name.

Thanks for a bit of sanity.

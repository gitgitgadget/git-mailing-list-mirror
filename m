From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 14:41:08 -0700
Message-ID: <xmqqwpyuayrv.fsf@gitster.dls.corp.google.com>
References: <1435020656.28466.8.camel@twopensource.com>
	<55898073.4010105@alum.mit.edu>
	<1435089205.28466.56.camel@twopensource.com>
	<1435095301.28466.76.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 23:41:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7Vwg-0001eX-KA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 23:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933907AbbFWVlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 17:41:18 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36419 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933657AbbFWVlL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 17:41:11 -0400
Received: by igbiq7 with SMTP id iq7so84985363igb.1
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=YpvptECfZ0pe9wjziG7HDCCOk6AtMN1lWNyVYrtSuJU=;
        b=tBPUklEf18h6tKZYUfcUy0r8w6JB39NElTE8E30xGn2UZkn0hmi87FH+FQE81FNghA
         V187AmPEooBDOkkLZiqhFMsIZ9AG71yxtk60zFlqifyyfRUaNN1uFcHfJ53bpfNm9bMR
         WgXoVp22INC4Fq6nlbFfosYoZWaB2MuCkXZ9v6tcYa5IBozJGodNlFIhYg6JpEm87oCK
         VGu/IUGwqLuftXzbumoOqL6gfnLkG1/ze+LOrwa2saUXUSAsCXXcEqZNcHRTjzsmFtoa
         gVdSJv5YpQbZe1iYQn0txOrMqBzBdRb/4mYSMTy4dbQSYEN5lN4Ve0x2vudtMFyS+vJ5
         mYzw==
X-Received: by 10.43.24.134 with SMTP id re6mr15709720icb.74.1435095670546;
        Tue, 23 Jun 2015 14:41:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3c90:65f7:f86b:dfda])
        by mx.google.com with ESMTPSA id l128sm15904496iol.1.2015.06.23.14.41.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 23 Jun 2015 14:41:09 -0700 (PDT)
In-Reply-To: <1435095301.28466.76.camel@twopensource.com> (David Turner's
	message of "Tue, 23 Jun 2015 17:35:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272522>

David Turner <dturner@twopensource.com> writes:

> On Tue, 2015-06-23 at 15:53 -0400, David Turner wrote:
>> > * Regarding MERGE_HEAD: you take the point of view that it must continue
>> > to be stored as a file. And yet it must also behave somewhat like a
>> > reference; for example, `git rev-parse MERGE_HEAD` works today.
>> > MERGE_HEAD is also used for reachability, right?
>> > 
>> > Another point of view is that MERGE_HEAD is a plain old boring
>> > reference, but there is some other metadata related to it that the refs
>> > backend has to store. The file-based backend would have special-case
>> > code to read the additional data from the tail of the loose refs file
>> > (and be sure to write the metadata when writing the reference), but
>> > other backends could store the reference with the rest but do their own
>> > thing with the metadata. So I guess I'm wondering whether the refs API
>> > needs a MERGE_HEAD-specific way to read and write MERGE_HEAD along with
>> > its metadata.
>> 
>> You are probably right that this is a good idea.
>
> On reflection, I think it might make sense to keep MERGE_HEAD as a file.
> The problem is that not only would refs backends have to add new
> MERGE_HEAD-handling functions, but we would also need new plumbing
> commands to allow scripts to access the complete contents of MERGE_HEAD.
> That seems more complicated to me.  

I think you are talking about FETCH_HEAD, but I tend to agree.

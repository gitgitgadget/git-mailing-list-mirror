From: Evgeny <evgeny.zislis@gmail.com>
Subject: Re: [PATCH] mergetool: export variables for use by custom mergetools
Date: Sun, 18 May 2008 02:55:10 +0300
Message-ID: <b6840c770805171655y691fbd0vd2d65d0914757b63@mail.gmail.com>
References: <8b4e944ac849029f31f403ab75198ed6fb4197c1.1211056369.git.davvid@gmail.com>
	 <20080517233414.GA28196@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "David Aguilar" <davvid@gmail.com>, tytso@mit.edu,
	git@vger.kernel.org
To: "Charles Bailey" <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Sun May 18 01:56:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxWGQ-00068B-J0
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 01:56:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbYEQXzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2008 19:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbYEQXzO
	(ORCPT <rfc822;git-outgoing>); Sat, 17 May 2008 19:55:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:48986 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753845AbYEQXzN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 May 2008 19:55:13 -0400
Received: by ug-out-1314.google.com with SMTP id h2so190675ugf.16
        for <git@vger.kernel.org>; Sat, 17 May 2008 16:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=9+D2PadQsXHgdpRXetdgIiKfG864uB3O8R6oYw8F+Fw=;
        b=sVN1m27+VlKIEnAAxQZXhgf5GcqnsFZOHWn3UP7IXRerEHwg9DsBazEMjQHTCBUXQEpqHRBBOLc02yDj0IVlpyPR1Mhof6UDrZmT+h5yLwLdBZz2YJV/ebeYi5MslqdtYxg/2M77L+5AV/N7a9pHwFN5qM5IaXojH+UMhxqRfqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CY5S7f9NeuJYQCuGlLChQOSQu1eJaDkkBwaTeA9EN0JYFTM1kuUUXKh1XjXs04bIrYtsYw2z5Mbn74I06nKhGNRLMRSQw8rPTmQxSNUCymqSRIFvN5kMiie5XUFBWdVv4nZCd7DaNl++Q69Jo71cqgkPzzoYTSTcmVoPrJAYEyk=
Received: by 10.67.19.13 with SMTP id w13mr1648199ugi.19.1211068510410;
        Sat, 17 May 2008 16:55:10 -0700 (PDT)
Received: by 10.67.26.8 with HTTP; Sat, 17 May 2008 16:55:10 -0700 (PDT)
In-Reply-To: <20080517233414.GA28196@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82368>

Ohh, so the documentation is not clear then. Now that you say it this
way, I finally understant that I should have in my ~/.gitconfig
something like:

[mergetool "p4merge"]
	cmd = p4merge.sh "$PWD/$BASE" "$PWD/$REMOTE" "$PWD/$LOCAL" "$PWD/$MERGED"
	keepBackup = false

[merge]
	tool = p4merge


Thanks for the explanation!
I believe that an example in the documentation could be a nice
addition, to clear things up in the future.

PS: The latest version of P4Merge did not work without the $PWD/
(fullpath). strange, but an older version worked okay even without it.


No patch is needed -- all is great, thank you great people! :)

Thank you Charles!



-
Evgeny


On Sun, May 18, 2008 at 2:34 AM, Charles Bailey <charles@hashpling.org> wrote:
> On Sat, May 17, 2008 at 01:39:26PM -0700, David Aguilar wrote:
>> The MERGED, BACKUP, LOCAL, REMOTE and BASE variables were not being
>> exported from the git-mergetool.sh script.  This prevented custom
>> mergetools from being able to use them.
>>
>> We now export them so that arbitrary mergetools can easily interact
>> with git mergetool.
>>
>> This problem was Reported-By: Evgeny <evgeny.zislis@gmail.com>
>>
>> Signed-off-by: David Aguilar <davvid@gmail.com>
>
> I think there must be a misunderstanding here. The variables are not
> designed to be exported. The point of the custom merge tool patch to
> git mergetool was to support custom mergetools without the need for a
> wrapper script, just a git config variable.
>
> I know that (with the right config) git mergetool supports p4merge as
> it is one of a selection of tools that I tested it with. You should be
> able to get p4 merge to work by setting the config variable:
>
> mergetool.p4merge.cmd
>
> to the value (IIRC, and I don't have the p4merge documentation to hand):
>
> p4merge "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
>
> Getting the quoting correct on this depends on whether you set it via
> commandline or via editing a git config file and can be a little
> tricky.
>
> If you have a wrapper shell script then you can easily pass these as
> positional parameters and re-export them as necessary.
>
> --
> Charles Bailey
> http://ccgi.hashpling.plus.com/blog/
>

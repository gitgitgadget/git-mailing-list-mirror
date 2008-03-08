From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: AssertionError in "stg uncommit" when going too far back
Date: Sat, 8 Mar 2008 12:19:58 +0000
Message-ID: <b0943d9e0803080419y6373ce62xfb108a15203858c7@mail.gmail.com>
References: <1204753622.17845.16.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Sat Mar 08 13:20:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXy2Y-0001oO-Sg
	for gcvg-git-2@gmane.org; Sat, 08 Mar 2008 13:20:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbYCHMT7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 07:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbYCHMT7
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 07:19:59 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:12281 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367AbYCHMT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Mar 2008 07:19:58 -0500
Received: by rv-out-0910.google.com with SMTP id k20so522602rvb.1
        for <git@vger.kernel.org>; Sat, 08 Mar 2008 04:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=5bg1BosnVsPDW9I0AItlEjh3p09AVB9oGL7XvtLJndM=;
        b=TH4smhz4pbjQWfPC3Ol02B3Bq1doFoummvmplEa3jl/TFg+EusyGFEAaX7LGJM9tVK0ze7PlykPBPUJVxHstzxQRnIP+SA7CJmkyf/Q840O6vWdOc8/a6LSsTvUbKnwYO1x5df6gzXu4s1obhtVZE4KHdSaFAi6+nSyJgjLzeog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=w/ssKIDljG2PCQsyQ6YCEoSup+vuRiQ0BRdiH3lI6hNgJnNNvOl+0dv6bqYqzVWvRkR/yPS03SQWZKSuqOET70IegaUwnMn5fn97gKWrGkWLOVHq7QRjC10LddCdzUmwvk3Qo0cqrVONt4lGKcBhfhRPJsaNg73wcWncyXFnXZo=
Received: by 10.141.23.7 with SMTP id a7mr1729356rvj.58.1204978798507;
        Sat, 08 Mar 2008 04:19:58 -0800 (PST)
Received: by 10.141.206.19 with HTTP; Sat, 8 Mar 2008 04:19:58 -0800 (PST)
In-Reply-To: <1204753622.17845.16.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76559>

On 05/03/2008, Pavel Roskin <proski@gnu.org> wrote:
> "stg uncommit" causes AssertionError if the number commits to uncommit it too large:
>
> $ stg uncommit -n 10000
> Uncommitting 10000 patches ... Traceback (most recent call last):
>  File "/home/proski/bin/stg", line 43, in <module>
>    main()
>  File "home/proski/lib/python2.5/site-packages/stgit/main.py", line 278, in main
>  File "home/proski/lib/python2.5/site-packages/stgit/commands/uncommit.py", line 94, in func
>  File "home/proski/lib/python2.5/site-packages/stgit/lib/git.py", line 171, in parent
> AssertionError

That's on the master branch. I think on the stable one, it used to
report a message like "Commit doesn't have exactly one parent".

In the latest version, we should indeed raise an exception rather than
just assert. I wouldn't declare a new exception class but rather use
an existing one with a meaningful error message. We can't recover from
this anyway and we would simply cancel the operation. I'll let Karl
comment on this as well.

Thanks for reporting it.

-- 
Catalin

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: RFC PATCH: support for default remote in StGIT
Date: Sun, 10 Dec 2006 16:41:10 +0000
Message-ID: <b0943d9e0612100841h7d064c7cs37f882f91e3eddf8@mail.gmail.com>
References: <1165657360.2816.61.camel@portland.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 10 Dec 2006 16:41:18 +0000 (UTC)
Cc: "GIT list" <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=K/YXsLuEZxjASwz0Q46zZFNJ/7wh5Ud63+OJjIRQbzdrDVfI4hGlYGnAzk9xEIs/fPRxT3SRmAg5TmorGMW3AE3pwoOQIqKwYP6ygUqppSjwkngFGTWHnglHVm8cGgW9FmkCpay/MvZLxx8oBTB2pN5fIOqbuP8XGO339bTkBjc=
In-Reply-To: <1165657360.2816.61.camel@portland.localdomain>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33899>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GtRjn-0000DE-7t for gcvg-git@gmane.org; Sun, 10 Dec
 2006 17:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762256AbWLJQlM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 10 Dec 2006
 11:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762258AbWLJQlM
 (ORCPT <rfc822;git-outgoing>); Sun, 10 Dec 2006 11:41:12 -0500
Received: from nz-out-0506.google.com ([64.233.162.228]:18964 "EHLO
 nz-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with
 ESMTP id S1762256AbWLJQlL (ORCPT <rfc822;git@vger.kernel.org>); Sun, 10 Dec
 2006 11:41:11 -0500
Received: by nz-out-0102.google.com with SMTP id s1so684900nze for
 <git@vger.kernel.org>; Sun, 10 Dec 2006 08:41:11 -0800 (PST)
Received: by 10.65.219.17 with SMTP id w17mr8157577qbq.1165768870894; Sun, 10
 Dec 2006 08:41:10 -0800 (PST)
Received: by 10.65.133.7 with HTTP; Sun, 10 Dec 2006 08:41:10 -0800 (PST)
To: "Pavel Roskin" <proski@gnu.org>
Sender: git-owner@vger.kernel.org

On 09/12/06, Pavel Roskin <proski@gnu.org> wrote:
> Sorry, I was unlucky to pick your address from setup.py, where it's
> incorrect (gmail.org, not gmail.com), so I'm sending you another copy.

Thanks for spotting this.

> One approach is to leave the default remote selection completely to git.
> The downside is that StGIT prints the remote it's pulling from.  Now
> StGIT will have to print common words that it's pulling something.  Or
> maybe it shouldn't print anything?

Yann started a thread on this but I didn't find the time to look at
this properly. He's idea was to store the remote branch information in
the StGIT metadata but I'd like to leave this for GIT to deal with.

The StGIT UI can probably be modified to display something useful but
I don't see a problem if it doesn't.

> The other approach is to calculate the default remote in StGIT.  This
> would allow StGIT to tell the user where it's pulling from.
>
> However, I had to introduce a function that ignores errors except there
> is any output on stderr.  This is because git-repo-config returns error
> code 1 if it cannot find the key.  Maybe git-repo-config should have an
> option not to fail in this case?  Perhaps a default value to return?

With the recent changes, StGIT shares the config files with GIT and it
has direct access to git settings without the need to use
git-repo-config. Just use "config.has_key" and "config.get_option".

Maybe a combination of your two options - StGIT could try to get the
default branch and, if there isn't any in the config files, just
invoke git-pull without any argument (and display something like
"pulling from default").

-- 

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git fast-import : How to change parent during import?
Date: Tue, 8 Mar 2011 16:23:28 -0600
Message-ID: <20110308222328.GE26471@elie>
References: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
 <20110308024427.GA21471@elie>
 <AANLkTini6NgeYxRdFtSDKe8GEEszDvXwRtLnuymiRNt4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 23:23:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Px5Jc-0001Mr-Ht
	for gcvg-git-2@lo.gmane.org; Tue, 08 Mar 2011 23:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab1CHWXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2011 17:23:35 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50133 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab1CHWXe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2011 17:23:34 -0500
Received: by qwd7 with SMTP id 7so4316265qwd.19
        for <git@vger.kernel.org>; Tue, 08 Mar 2011 14:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=OEUxoWRLg2JPTINbMCAZvpsAp7v8C3VcpKD+0KGosGY=;
        b=SK1g+G5gRGzN16xyMF9Bimb+u5b+DCP9h+4pr6wOvrf1jgiUfWqFMwe67rCo97Tkcd
         qfU7ExXoGOiGVK6tlBStnYq8FAHUqphu2zEEL9MUwAbLM5e+kEW4Xb1cdV0Elu4V7RIh
         lWYIFGHzcC2Q7+AnyJ79/Rz/Px8rSK15wQYn4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=nsJBHMvMRSc7wztFB0OrOsuCnq5UagIdJJlcR1eMqncuUqJ4lf5N9nZwCbS9DNu51r
         PcEl7FIwAXKvOHKcP5idq13c6rOG/uaOJc/tHPzgYXZpm/FV5IUMk3TYFtvniF9JUzCU
         1KaRjQbPzNQaOXI9hDITQ7gwVpgn1i36qeShs=
Received: by 10.224.27.141 with SMTP id i13mr3211933qac.239.1299623014001;
        Tue, 08 Mar 2011 14:23:34 -0800 (PST)
Received: from elie (adsl-69-209-61-99.dsl.chcgil.sbcglobal.net [69.209.61.99])
        by mx.google.com with ESMTPS id y17sm884167qci.45.2011.03.08.14.23.31
        (version=SSLv3 cipher=OTHER);
        Tue, 08 Mar 2011 14:23:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTini6NgeYxRdFtSDKe8GEEszDvXwRtLnuymiRNt4@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168709>

Hi,

Vitor Antunes wrote:
> On Tue, Mar 8, 2011 at 2:44 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> The advice in the section "Use Tag Fixup Branches" of git-fast-import(1)
>> might be useful.
>
> I'm still trying to understand it. Do you know of any practical
> example that I can look into?

It's likely I misunderstood what you're trying to do.  If you have
some work in progress, I'd be glad to look at it.

Anyway, concerning tag fixup branches: git://repo.or.cz/cvs2svn.git
has an example in cvs2svn_lib/git_output_option.py::process_tag_commit.
The idea is to make commits that don't belong to any branch on a
separate TAG_FIXUP ref, using the "reset" command where appropriate;
then the resulting commits can be inspected, merged, reset to, or used
in some other way later.

The "tag fixup" idea is that in VCSes like CVS, tags do not
necessarily match the content on any branch.  So the history looks
somewhat like so (time flowing left to right):

                     TAG
                    /
 o --- o --- o --- o --- o --- o ...

instead of the perhaps more sensible

 o --- o --- o --- TAG --- o --- o ...

The side branch leading up to a tag does not correspond to any branch
name; after it is in the correct state one can use the "tag" command
to get it remembered in permanent history.  The same technique might
be useful whenever you are creating history that is not meant to stay
permanently on any branch.

Jonathan

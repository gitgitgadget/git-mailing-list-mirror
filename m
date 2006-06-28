From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: CFT: merge-recursive in C (updated)
Date: Wed, 28 Jun 2006 13:35:10 +0200
Message-ID: <81b0412b0606280435t70ac9957jae2c4d1c10b7681d@mail.gmail.com>
References: <81b0412b0606270848v2253209aw52466de632ab25c1@mail.gmail.com>
	 <Pine.LNX.4.63.0606271830210.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20060627223249.GA8177@steel.home>
	 <81b0412b0606280234x7d07fbbck7887b5214d98bf91@mail.gmail.com>
	 <Pine.LNX.4.63.0606281202360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Fredrik Kuivinen" <freku045@student.liu.se>,
	"Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Jun 28 13:35:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvYKE-0007Yc-Dm
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 13:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423279AbWF1LfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 07:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423281AbWF1LfN
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 07:35:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:54494 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423279AbWF1LfL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jun 2006 07:35:11 -0400
Received: by ug-out-1314.google.com with SMTP id a2so3073392ugf
        for <git@vger.kernel.org>; Wed, 28 Jun 2006 04:35:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LSO8PqkvNF9aOyCf2rHRSKgSlNogY3dM1r1brxsz+mnvzTgeU9/EeReSMWYyZYM+S8zyTsliEkETOQ23QV8IqtLTCfmYIsUbyZIp0HbAFYanxz4/0kKGSsePo3szH4u7CmnQ1634B7VClcPEjWjthwiazeYl9RdJnHBPh/zfnYE=
Received: by 10.78.97.7 with SMTP id u7mr233344hub;
        Wed, 28 Jun 2006 04:35:10 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Wed, 28 Jun 2006 04:35:10 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606281202360.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22804>

On 6/28/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > > - use a pipe to "git-update-index --index-info" instead of using command
> > > > > line
> >
> > ...and to take it a step further, a patch (0002) to avoid too many calls to
> > git-write-tree and to git-update-index.
>
> ... and introduces a lot more lines doing debug output.

well, that's how I found out about what to fix. Was really impressed
when saw the difference :)
What stands out next is getRenames (to be renamed into get_renames),
a little profiling shows that the renames lists are the culprit this time too.

I actually expected these problems, but decided to postpone the
optimization for later: linked lists are comfortable to work with.
I didn't had much time for this project, and the first commit is
dated 7th June - it was a very slow progress.

> However, the change is good, but I would not call it "FILE *fp". IMHO
> "FILE *update_index_pipe" would explain better what you do there.

just update_index would be enough. It can't possibly mean anything else,
being FILE* in that context.

By the way, is it safe to use "git-update-index --index-info"?
AFAICS it was designed for this kind of use, but the most
visible user of it (git-update-recursive.py) didn't use --index-info
this way! Was there any specific reasons?

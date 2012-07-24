From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for
 testing.
Date: Tue, 24 Jul 2012 14:50:49 -0500
Message-ID: <20120724195049.GD5210@burratino>
References: <7v4noyo6tc.fsf@alter.siamese.dyndns.org>
 <1343074107-23262-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <7v8veakyar.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	davidbarr@google.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:51:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Stl8G-0006fE-SB
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537Ab2GXTuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:50:55 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65452 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab2GXTuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:50:55 -0400
Received: by yhmm54 with SMTP id m54so7095278yhm.19
        for <git@vger.kernel.org>; Tue, 24 Jul 2012 12:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0BJlf7eg9xUxlgOoXrki/uSQfO21k33i9dp1mFv4XkE=;
        b=voUOXqfloPfO4ysBSjPISoNLJDm/HMmMdbE3jO1GMQYV/GzN7xgsN1sDVIYBXg6YdW
         0P5bgAX2f0leKdAslZ2STQbd5QGx5LHPNHgeP6ykFekS9DgWtdBq/Bo1ZnY218AzHS0x
         OEKpjY7waC/8EIoE9oa6ZN/yDpYOmnxEUJB4YPda+sUe9iZf0AV/TQj7XDRLnDHSuteQ
         TN9JgVCEZc7hglJ4A1tfGPvKLyOcxsjROligJ9cCE8z3XmFbsvvjKx1wZQyrJk4eF6V0
         AbNIqQaVzG44nlpQa4rSg6ml+1pdSwAa/6/1KuSb1TDnkVTM0Jwf0Fi8ae7VriEeOCyt
         3o9g==
Received: by 10.42.38.200 with SMTP id d8mr12608558ice.19.1343159454077;
        Tue, 24 Jul 2012 12:50:54 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id dw5sm2761496igc.6.2012.07.24.12.50.53
        (version=SSLv3 cipher=OTHER);
        Tue, 24 Jul 2012 12:50:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v8veakyar.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202062>

Hi,

Junio C Hamano wrote:
> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:

>> To ease testing without depending on a reachable svn server, this
>> compact python script mimics parts of svnrdumps behaviour.
>> It requires the remote url to start with sim://.
[...]
>> To allow using the same dump file for simulating multiple
>> incremental imports the highest visible revision can be limited by
>> setting the environment variable SVNRMAX to that value. This
>> effectively limits HEAD to simulate the situation where higher
>> revs don't exist yet.
>
> It is unclear how this is different from giving the ceiling by
> specifying it as the "END" in -rSTART:END command line.  Is this
> feature really needed?

I think the idea is that you put this script (or a symlink to it) on
your $PATH with higher precedence than svnrdump and run a command
that expected to be able to use svnrdump.  Then instead of going to
the network, the command you run magically uses your test data
instead.

If the command you are testing wanted to run "svnrdump" without the
upper endpoint set, we need to handle that request, either by emitting
all the revs we have, or by stopping somewhere.  The revlimit feature
provides the "stopping somewhere" behavior which is not strictly
needed but is presumably very useful when testing incremental fetch.

Florian, do you mind if I make the revlimit feature a separate patch
when applying this?

Anyway, it looks good and reasonable to me, so will apply.

Thanks.
Jonathan

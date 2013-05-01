From: Ilya Basin <basinilya@gmail.com>
Subject: Re: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Wed, 1 May 2013 09:09:26 +0400
Message-ID: <1438528085.20130501090926@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ray Chen <rchen@cs.umd.edu>, Eric Wong <normalperson@yhbt.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 01 07:11:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXPJz-00041Q-Lz
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 07:11:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400Ab3EAFLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 01:11:11 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:32836 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849Ab3EAFLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 01:11:07 -0400
Received: by mail-lb0-f174.google.com with SMTP id t11so1175963lbd.5
        for <git@vger.kernel.org>; Tue, 30 Apr 2013 22:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=6NB2Dw9UY7ZglujgdHwnU9G3ehYRHXDJlaRun/k+Uns=;
        b=wAmWhgcABGfej1LAvOBFJIDwPSqQsRoUwVU20oPcClOLaRszx9fPosWeVw18tdSo2E
         xD0TQehGjLa4fXqkJqtfsYBG2gdwmmL8nGkY9ZvtVs71psA5tcIV/+ayeYZsVn0vwX4O
         +NBI0CqFAmD+qGOsiTOCdKqC1vYcuaH41rp8kVkw/ArSXm+kUplUyaM3lmja3iqwi4cX
         qVxXhpuz82j0MdhH5Ki/dyxANKHFGA/jViupLMoUYefxV2kmJoIQbbauou0VeQG4zIKB
         Pbi7QiNzqyL5EXu2O0K7S+BoHuObA2J5pLwVCkPSQkfsz8u0pdxtfdlZ4QHxlSCK2G9E
         MliA==
X-Received: by 10.112.181.163 with SMTP id dx3mr615855lbc.126.1367385066118;
        Tue, 30 Apr 2013 22:11:06 -0700 (PDT)
Received: from [192.168.0.78] (92-100-238-23.dynamic.avangarddsl.ru. [92.100.238.23])
        by mx.google.com with ESMTPSA id b8sm442053lak.8.2013.04.30.22.11.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 22:11:05 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223069>

IB> +       return undef if (!keys $self->{_save_ph});
Correct is: return undef if (!keys %{$self->{_save_ph}});

In my repo the placeholders change too often (in 1/4 commits). I'm
thinking of using:
'git config --unset "svn-remote.$repo_id.added-placeholder" path_regex'
instead of full rewrite.

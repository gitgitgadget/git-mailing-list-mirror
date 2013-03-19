From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2 0/6] make pathless 'add [-u|-A]' warning less noisy
Date: Tue, 19 Mar 2013 15:44:00 -0700
Message-ID: <20130319224400.GA19014@google.com>
References: <1362786889-28688-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 23:44:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UI5Go-0007wW-Ah
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 23:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934159Ab3CSWoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 18:44:10 -0400
Received: from mail-pb0-f48.google.com ([209.85.160.48]:61598 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289Ab3CSWoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 18:44:08 -0400
Received: by mail-pb0-f48.google.com with SMTP id wy12so801144pbc.35
        for <git@vger.kernel.org>; Tue, 19 Mar 2013 15:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TvPDCMVekgwh5K8cavC8aLYXAxZ2JARPuTzZjLNTkTo=;
        b=NH6Ck8hhIMIDoK0fBdFhPYaV6Mwbth5FAH5hdEfIjz5oPSaav4TubElPpot5QktXjQ
         WIH8Ddkow40FG/Xc5dTJ09M3HMGd8Pjp48GvNC/7ZASjFPPPru1ZBT+wl+qvWueOyEFN
         KF4Ter8JQ6c78hdIY0DXk4qwOH0ej6kk6DTw6lw1ANFkYlATWBFZ7xPSRX41Stpd0P3u
         5E5N9BiX5fHCqY8GmNkAzXlcoTIw2hgseCJKWZR2tJ3yhy26KM0+n8zEzqu+s9wKQRrM
         n6dfObmOGI67xrx5xLlwLkofSHBRm0YW5Q7H33j8iJxuVnppF5NSdbsW0Hur9hywLxtV
         JyNw==
X-Received: by 10.66.155.67 with SMTP id vu3mr5995582pab.70.1363733048319;
        Tue, 19 Mar 2013 15:44:08 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id rt13sm14235999pac.14.2013.03.19.15.44.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 Mar 2013 15:44:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1362786889-28688-1-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218560>

As promised, here is a rerolled version of the "make pathless 'add
[-u|-A]' warning less noisy", incorporating patches from
jc/add-2.0-u-A-sans-pathspec.  Thanks for your help so far.

Just like jc/add-2.0-u-A-sans-pathspec, the only transition in this
series is the "pull the bandaid" kind.  That is, there are two steps:

 0. the current state, where the warning is a little too noisy
 1. the current state but with the warning only firing in cases
    where the user will be affected by the change to default
    'git add -u' behavior
 2. no more warning, 'git add -u' defaulting to 'git add -u :/'

Patch 1 is the same as in jc/add-2.0-u-A-sans-pathspec, included for
reference.

Patches 2-5 correspond to the original patches 1-4.  Any changes are
described after the '---' in each patch.

Patch 6 is just the patch from the tip of jc/add-2.0-u-A-sans-pathspec,
rebased.  It is meant to be applied in the 2.0 cycle.

Jeff King (1):
  t2200: check that "add -u" limits itself to subdirectory

Jonathan Nieder (4):
  add: make pathless 'add [-u|-A]' warning a file-global function
  add: make warn_pathless_add() a no-op after first call
  add -u: only show pathless 'add -u' warning when changes exist outside
    cwd
  add -A: only show pathless 'add -A' warning when changes exist outside
    cwd

Junio C Hamano (1):
  git add: -u/-A now affects the entire working tree

 Documentation/git-add.txt | 16 +++++++-------
 builtin/add.c             | 56 ++++++++---------------------------------------
 t/t2200-add-update.sh     | 11 ++++++++++
 3 files changed, 28 insertions(+), 55 deletions(-)

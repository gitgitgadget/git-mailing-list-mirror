From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for check_refname_component
Date: Thu,  5 Jun 2014 19:56:14 -0400
Message-ID: <1402012575-16546-1-git-send-email-dturner@twitter.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jun 06 01:58:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WshYA-00087s-5m
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 01:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613AbaFEX6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 19:58:22 -0400
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34108 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbaFEX6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 19:58:21 -0400
Received: by mail-qg0-f54.google.com with SMTP id q108so2901274qgd.41
        for <git@vger.kernel.org>; Thu, 05 Jun 2014 16:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=tpp+chW1MbxJ/Sb5uE9DKdaOeoDTLiy1+wbSfH1ByqI=;
        b=BSmLvaMAlpp2z/wh/Ry1pZ+DzVsXJeXjhstPUVTBjH2yLNXo8iXjyGtTPIxutT12I0
         Jvze792Ktzre+ZNN7orSYbfjqDY/N6mFPvpxylstjp5oOeT+T0kC7j1h+hfTc+wHMRAY
         YFSIoNaJPrm1h74+NWZriIoNMaLLhB/zzuv0eDRemjN+JqZnAleSQ34DBMhoAAUe5WTl
         i9voEFTamWnhq+djA8QjkOutQasERXHjLUmZb2OXZ90AxUkVAqqNdTGsBvAZRtlpDKGb
         j7I/k6COfhoJW1id9ZCpN0X0bk4MLKpixJpkis9vwzDpXPwwXzAjkhCoITublbiUVnF4
         pkng==
X-Gm-Message-State: ALoCoQkbWKhRI4IAncffYxIDA+ZkJtafNIC+AZfJNqY6POq0stK8xOAyLt45PgRzQQ84ERXIFJ1S
X-Received: by 10.224.163.8 with SMTP id y8mr1805368qax.46.1402012701073;
        Thu, 05 Jun 2014 16:58:21 -0700 (PDT)
Received: from stross.twitter.corp ([38.104.173.198])
        by mx.google.com with ESMTPSA id l46sm4719383qga.21.2014.06.05.16.58.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Jun 2014 16:58:20 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 2.0.0.rc1.24.g0588c94.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250882>

Since Junio has picked up the first patch from previous versions of
this series, I'm just going to send the second (SSE) one.  I decided
not to s/NO_SSE42/!HAVE_SSE42/ because it looks like git mostly uses
the former convention (for instance, that's what GIT_PARSE_WITH
generates).

Thanks for all of the comments so far.

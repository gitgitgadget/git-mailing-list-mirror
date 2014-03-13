From: Shawn Pearce <spearce@spearce.org>
Subject: No progress from push when using bitmaps
Date: Wed, 12 Mar 2014 17:21:21 -0700
Message-ID: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 13 01:21:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNtPA-0000hR-JH
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 01:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbaCMAVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 20:21:43 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:58777 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaCMAVn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 20:21:43 -0400
Received: by mail-wg0-f41.google.com with SMTP id n12so220758wgh.12
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 17:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=R+bpkUI2baR5Ai6b/OEqNi9oYGSSP8/AZ7N7Bh5miwo=;
        b=e3fLuB6kIwj8kr4yxWj7xI9YYbNnGb+yUkgshfyhHEHsIaTLIOruc6c663u0kxwUxQ
         cT6XFjr31SPcm6OH2QM2RZwo1QuyA5jMHgFOIyiwFFPJPxhDytQk+K9PjfxhY18zkCY3
         juGSBUTSNtehJMioGjr5xp0C21xIv6ewgM850=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=R+bpkUI2baR5Ai6b/OEqNi9oYGSSP8/AZ7N7Bh5miwo=;
        b=k+Fd0WXsOt6PNjcygJjajyUjv2ofbHEv6huobH2b9zuFjQNmi2h792gyJEeOV2K9GM
         NFZmlc2zlMYE5jUMpjDm0c4M+wCxASjG6UTKjDzH044aJVRPF9+aWq3TXnuX5wKtRf0J
         ao6fyWNZmzx186p30SV6J4u68VrLNilucG4dLBF7bjIQ4aGI8RqupEcYHgsivNWNwhGl
         d79/ho5iEPpbwXhnFLXQkPpETXiKwbE/9dRWWDFOX6gVDURGLg21orBm1R4+LvPF4p6g
         wxgeZY6CP+jh0nLka0m7UrsKeke//+5m7YkQyulZbrUxc9laErwszhbsaRuoTxbvtzJE
         9sGA==
X-Gm-Message-State: ALoCoQnulh5lGEPs8YasvoeP5RCqNY8DL5CNaxoFqbSn+cn5xjAqy7jI4/SXSsgy59mXdwdUGG0t
X-Received: by 10.180.101.166 with SMTP id fh6mr846908wib.2.1394670101710;
 Wed, 12 Mar 2014 17:21:41 -0700 (PDT)
Received: by 10.227.7.131 with HTTP; Wed, 12 Mar 2014 17:21:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244014>

Today I tried pushing a copy of linux.git from a client that had
bitmaps into a JGit server. The client stalled for a long time with no
progress, because it reused the existing pack. No progress appeared
while it was sending the existing file on the wire:

  $ git push git://localhost/linux.git master
  Reusing existing pack: 2938117, done.
  Total 2938117 (delta 0), reused 0 (delta 0)
  remote: Resolving deltas:  66% (1637269/2455727)

This is not the best user experience. :-(

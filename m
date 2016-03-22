From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [RFC_PATCHv4 4/7] submodule init: redirect stdout to stderr
Date: Tue, 22 Mar 2016 08:46:15 +0100
Message-ID: <CAHGBnuMs4D0LeMvdcS0yzKoQgmE+UTb+QFfOkSy7T20PbH86UQ@mail.gmail.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
	<1458612372-10966-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens.Lehmann@web.de, Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 08:46:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiH1B-00079Q-CP
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 08:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655AbcCVHqS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 03:46:18 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35024 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751770AbcCVHqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 03:46:16 -0400
Received: by mail-vk0-f51.google.com with SMTP id e6so243808316vkh.2
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 00:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=NwYx+UswQXdVTIhcT8T9Q5Fj1jLCwyl0+7nr6tsoBFA=;
        b=qolvdN+t8n9cMZDitzmblnzX1p3npIZ2BCD59VsKpBAiWjDe9GAePc9/6nibH7aX4W
         5S5TONa30cptv3Kw/2L2P7rw/6vTzwSXw2bo0Dq9KjbLMgQS3db3SMkeJp5q2MB/6DEt
         Z3ztxcek8xL5Q/SPbtRhxoX/5lQLRdgrof70xmwhNaywGX8c7YQ6CBUzvOLTho6ooCUf
         5rZsWmCyX+dR6nLI1XMF5GxGGTJJXhqmYIkclXRkr3Xix1PoCqVANPV4KcjbMydK92G+
         FHTmDb1bz3nosMNDuguS5XSmdwHJcmefY86BnGO/iNYIqSNmHtZUegT7aY0sse/uWgdR
         HbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NwYx+UswQXdVTIhcT8T9Q5Fj1jLCwyl0+7nr6tsoBFA=;
        b=NuVjYs2VA4DUsPAaz2k9OPwb1CEG1jEkvxAlNODfXF0ggG7dpSSNPEikpQGJEs1BZ0
         hDgTP3t/0QV2NqP1QPfsIK4avwz49Wnu+ZyvSZMt96CbhJ1ySAbQToc1qUXbflYJevdb
         thnqOukf5k4n7lk90AWXn7DzEo4PeoxR8ENFO7TIBTDv0WJDy5WqMaXrChwv7WSSGg9T
         xbHUjkoZ66MZvDPF9kBFvZvGURBISyaDItYyJnIFbiylhSgfuQIA7c0KbudwCwuOR1aR
         BiuaAScQTJ0+yum8u6GoBskSc0ZiafkTSj/WKDAGXGFgta0IohuiC/yCIpr73YsUydyH
         TL0w==
X-Gm-Message-State: AD7BkJKGp5Z0rYrS4TK7IDQUAn0HgnlS4VoeNrfV2lMgUB2+3EWu72n9EkObBnJI4Lo4jEAjw7mnWaB6NL8rOg==
X-Received: by 10.176.1.231 with SMTP id 94mr3441091ual.77.1458632775587; Tue,
 22 Mar 2016 00:46:15 -0700 (PDT)
Received: by 10.176.68.6 with HTTP; Tue, 22 Mar 2016 00:46:15 -0700 (PDT)
In-Reply-To: <1458612372-10966-5-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289491>

On Tue, Mar 22, 2016 at 3:06 AM, Stefan Beller <sbeller@google.com> wrote:

> Reroute the output of stdout to stderr as it is just informative
> messages, not to be consumed by machines.

Just wondering, what's Git's policy on this? This message is neither
an error nor a warning, but just purely informational. As such it
semantically does not belong to stderr, or? On the other hand I see
multiple places in Git's code where printing to stderr is (mis-)used
for informational messages, probably to separate output to be consumed
by humans from output to be consumed by machines, like you do here.

-- 
Sebastian Schuberth

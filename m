From: Stefan Zager <szager@google.com>
Subject: Re: Make the git codebase thread-safe
Date: Thu, 13 Feb 2014 14:53:31 -0800
Message-ID: <CAHOQ7J8syoQLGwwkwPEX3wZir8sWDQ+k8sgHAKn=n_-Q_S8ipA@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
	<CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
	<CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
	<CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
	<CAHOQ7J_Jrj1NJ_tZaCioskQU_xGR2FQPt8=JrWpR6rfs=c847w@mail.gmail.com>
	<CABPQNSYVGc9m0_xfAWe=3b7CXyGZ-2FfTMRbTJ=UECeZUtdgmg@mail.gmail.com>
	<52FBC9E5.6010609@gmail.com>
	<loom.20140213T193220-631@post.gmane.org>
	<52FD4C84.7060209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Zachary Turner <zturner@chromium.org>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 23:53:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WE5A1-0007TW-2j
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 23:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbaBMWxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 17:53:33 -0500
Received: from mail-ob0-f172.google.com ([209.85.214.172]:57040 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbaBMWxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 17:53:32 -0500
Received: by mail-ob0-f172.google.com with SMTP id vb8so13155410obc.31
        for <git@vger.kernel.org>; Thu, 13 Feb 2014 14:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/YG9UapF7y05ZbATi3SKPo9THPh9A4ZvWxpGksJbzEI=;
        b=iXdbhm0vd2+LrXEUzvG6sw6Pra/A1CKWH5a+V+jiIUXjWaaKsekp3qDK+gY7AQiwFx
         Eq4c+staSD7LvLTC/UQATtKwiUJeZfelrwH/u5HufQOWXlEmMO6polM0q1G4FIe77dNM
         dXuFP3labx7N3Qktl0fQF9zG62tRLAI+T/TrLX4u6sNMg6tU3P7+HIX3cWaoUNRuDwIC
         eGPdLyAGwVLafAG786ESEW8ti5GFBcyfXpxL6piBIT9ZVEWOU1f/fhck9ivvzZEebojF
         mvYiXKVfHq/kSNfbYfdP8rjvSB1usVtzypt+d1CuW81RU9dLrvLQTU6GYtkq7R/8EyXN
         LgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=/YG9UapF7y05ZbATi3SKPo9THPh9A4ZvWxpGksJbzEI=;
        b=BipsPsBZUNgn01gAI7uP2qvf/2HOnZep69dbYJnXzL1SvX6M/rv6jEcA9OKF6Ixnb6
         kHThb3L1dRCHgx/00PdM3EaY2OIWixaxGZfrz/Z24IR3jYL4ltW5QZVebgHZmVLMGjfU
         HxNyvNnO+K8JPlH8vD+D+eV6yuDJp2w3BtkCbaMCagvRD0JpeLrAyOHJe7/7nnsvEuxI
         cU1E7Ts94jD42qR72qrJocOIUGhMkZ1RzVr5AL1uFEUM6xVEtDIdym+FImh8sowr2jmk
         wJ+IOM/Kos2WI+XaQsu2asN9fY3QL6EZIRZ+ApKpf9fnPMZcQAvzlGzlDjkfYEZtQd/a
         xs9Q==
X-Gm-Message-State: ALoCoQmhowCt2wnb07pCTUuKRf4o0QTsuGu5o35mkVNdEMx9tDjblF2tGnjDohHAC5Hjaav9kLmsKpera0HDKrJL97aqR5bDzYMV89vuK9J/5BfOPmygzQxRYGsoAIyfOZQmsBpJC/BcPKEflxbAId7OmA3gmrM0cfdd5RP4AiBfDJpi71GFru28E8n2WArA6LB8pAGXEM9w
X-Received: by 10.182.44.167 with SMTP id f7mr3385335obm.3.1392332011419; Thu,
 13 Feb 2014 14:53:31 -0800 (PST)
Received: by 10.182.233.201 with HTTP; Thu, 13 Feb 2014 14:53:31 -0800 (PST)
In-Reply-To: <52FD4C84.7060209@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242084>

On Thu, Feb 13, 2014 at 2:51 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 13.02.2014 19:38, schrieb Zachary Turner:
>
>> The only reason ReOpenFile is necessary at
>> all is because some code somewhere is mixing read-styles against the same
>> fd.
>>
>
> I don't understand...ReadFile with OVERLAPPED parameter doesn't modify the HANDLE's file position, so you should be able to mix read()/pread() however you like (as long as read() is only called from one thread).

That is, apparently, a bald-faced lie in the ReadFile API doc.  First
implementation didn't use ReOpenFile, and it crashed all over the
place.  ReOpenFile fixed it.

Stefan

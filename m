From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH v2 0/2] better handle .gitmodules merge conflicts
Date: Sat, 14 May 2011 18:25:28 +0200
Message-ID: <4DCEACF8.50503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 14 18:25:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLHew-0000Cm-0f
	for gcvg-git-2@lo.gmane.org; Sat, 14 May 2011 18:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753390Ab1ENQZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2011 12:25:35 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:60004 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235Ab1ENQZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2011 12:25:35 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9733418EEC733;
	Sat, 14 May 2011 18:25:33 +0200 (CEST)
Received: from [93.240.103.149] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QLHen-0002mg-00; Sat, 14 May 2011 18:25:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18LZSDzJmRmG0g5cHYULGIgyOSBymZDrIyH81gq
	9QU/xs3ECe8tOz9547aFHANgW3INyTAjYtL7+uIBh8ItM+yBw7
	b0QTypYcfLVRPd8VNngw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173590>

Am 13.05.2011 08:19, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> +static int gitmodules_is_unmerged;
>
> Is it too cumbersome to pass this down the callchain as an argument?

I think so. Currently it influences the behavior of fetch, status,
the diff family and commit. Having for example gitmodules_config()
return that value and then pass it on would touch a lot of code (and
that impact would grow even further with the recursive checkout
series I'm working on).

So I thought it best to have this information statically in the
submodule.c file and let the call sites who need to know that call
functions there to get just the information they need and hide the
details in submodule.c.


All other issues raised have been addressed in this series.


Heiko Voigt (1):
  test that git status works with merge conflict in .gitmodules

Jens Lehmann (1):
  Submodules: Don't parse .gitmodules when it contains merge conflicts

 submodule.c                 |   31 +++++++++++++-
 t/t7506-status-submodule.sh |   92 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 117 insertions(+), 6 deletions(-)

-- 
1.7.5.1.291.g080bb

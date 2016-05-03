From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: t7900-*.sh tesr #5 failure
Date: Tue, 3 May 2016 22:34:58 +0100
Message-ID: <57291982.2000904@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 03 23:35:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhyL-0007jW-CW
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:35:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756544AbcECVfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:35:07 -0400
Received: from avasout07.plus.net ([84.93.230.235]:54150 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756519AbcECVfG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:35:06 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id pxb11s0092D2Veb01xb259; Tue, 03 May 2016 22:35:03 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=dRJa9r4XlhsGZmygdbYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293461>

Hi David,

Test t7900.5 fails for me, thus:

  $ ./t7900-index-helper.sh -i -v -x -d
  
  ...
  
  + test -S .git/index-helper.sock
  + git status
  On branch master
  Untracked files:
    (use "git add <file>..." to include in what will be committed)
  
  	err
  
  nothing added to commit but untracked files present (use "git add" to track)
  + test -S .git/index-helper.sock
  + grep -q . err
  error: last command exited with $?=1
  not ok 5 - index-helper autorun works
  #	
  #		rm -f .git/index-helper.sock &&
  #		git status &&
  #		test_path_is_missing .git/index-helper.sock &&
  #		test_config indexhelper.autorun true &&
  #		git status &&
  #		test -S .git/index-helper.sock &&
  #		git status 2>err &&
  #		test -S .git/index-helper.sock &&
  #		! grep -q . err &&
  #		git index-helper --kill &&
  #		test_config indexhelper.autorun false &&
  #		git status &&
  #		test_path_is_missing .git/index-helper.sock
  #	
  $ cd trash\ directory.t7900-index-helper/
  $ ls
  err  x.t
  $ cat err
  warning: We requested watchman support from index-helper, but it doesn't support it. Please use a version of git index-helper with watchman support.
  $ 

[Yes, that is one long line in err!]

[At least, this is one of the failures, I have also seen git status failing
with a SIGPIPE.]

Note that I do not have the watchman libraries etc., so USE_WATCHMAN is
not defined. Note also, that I had an instance of git-index-helper still
running after the test failure (which I kill-ed).

I haven't spent any time debuging this, but some questions spring to
mind:

    - can index-helper be used without watchman support?

    - why is index-helper requesting watchman support, when it was
      built without USE_WATCHMAN being defined?

    - why is read-cache.o exporting the verify_index and
      write_watchman_ext symbols?

    - is index-helper any use/help without watchman support?

    - is '! grep -q . err' meant to determine if the err file is
      empty (ie git status did not issue an error message)?
      [if yes, maybe 'test_must_be_empty err &&' would read better!]

Unfortunately, I have to run now, ...

ATB,
Ramsay Jones

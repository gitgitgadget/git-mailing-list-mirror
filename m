From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Mon, 09 May 2016 15:32:34 -0700
Message-ID: <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	<xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
	<1462832134.24478.49.camel@twopensource.com>
	<xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 00:32:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aztjG-0000qE-5f
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 00:32:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbcEIWci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 18:32:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56057 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753266AbcEIWch (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 18:32:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 493271A045;
	Mon,  9 May 2016 18:32:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=02T5TbLwvwhi8OEuzUzozYhjDfY=; b=uLkzY/
	r0HY0KxCbk0NNUjbVLU8zpGhaBT9ceNTXQJrI4c5JvrWBgwm0Q32SUpo0IS9Vf2j
	NqmfzWJRyOGws3XmGaSvINU4+4HUkjU+IquFiHUmiVz+G5yqiQSIi8B02h4cWPol
	3sUHm4kj7PwRA/VwWs30sJ3qWZPXPMztZJC1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NpHs4BKG5IdkN/HbAtsb3y33uKqX5sFb
	EOuweumjzlHZy0tpd/Dt8y0yb/TdADXuJpczJ/8NKfLkRuR+EzfGVFrFpvV/W4wm
	+gqKOAWZI3kpy8DsZ1NVcI8iBBwRD4O4fV077KC5b4zoyUwG8jboVKcuTCnSpedh
	MLbSzXDiYWA=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E5371A044;
	Mon,  9 May 2016 18:32:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AEA8D1A043;
	Mon,  9 May 2016 18:32:35 -0400 (EDT)
In-Reply-To: <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 09 May 2016 15:22:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EDA1F25E-1635-11E6-9C76-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294080>

Junio C Hamano <gitster@pobox.com> writes:

> David Turner <dturner@twopensource.com> writes:
>
>> On Mon, 2016-05-09 at 14:40 -0700, Junio C Hamano wrote:
>>> Hmmm, I seem to be getting
>>> 
>>>     $ cat t/trash*7900*/err
>>>     fatal: Already running
>>> 
>>> after running t7900 and it fails at #5, after applying
>>> "index-helper: optionally automatically run"

The symptom looks pretty similar to $gmane/293461 reported earlier.
Here is how "t7900-index-helper.sh -i -v -x -d" ends.


expecting success:
        test_when_finished "git index-helper --kill" &&
        rm -f .git/index-helper.sock &&
        git status &&
        test_path_is_missing .git/index-helper.sock &&
        test_config indexhelper.autorun true &&
        git status &&
        test -S .git/index-helper.sock &&
        git status 2>err &&
        test -S .git/index-helper.sock &&
        test_must_be_empty err &&
        git index-helper --kill &&
        test_config indexhelper.autorun false &&
        git status &&
        test_path_is_missing .git/index-helper.sock

+ test_when_finished git index-helper --kill
+ test 0 = 0
+ test_cleanup={ git index-helper --kill
                } && (exit "$eval_ret"); eval_ret=$?; :
+ rm -f .git/index-helper.sock
+ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        err

nothing added to commit but untracked files present (use "git add" to track)
+ test_path_is_missing .git/index-helper.sock
+ test -e .git/index-helper.sock
+ test_config indexhelper.autorun true
+ config_dir=
+ test indexhelper.autorun = -C
+ test_when_finished test_unconfig  'indexhelper.autorun'
+ test 0 = 0
+ test_cleanup={ test_unconfig  'indexhelper.autorun'
                } && (exit "$eval_ret"); eval_ret=$?; { git index-helper --kill
                } && (exit "$eval_ret"); eval_ret=$?; :
+ git config indexhelper.autorun true
+ git status
error: last command exited with $?=141
not ok 5 - index-helper autorun works
#
#               test_when_finished "git index-helper --kill" &&
#               rm -f .git/index-helper.sock &&
#               git status &&
#               test_path_is_missing .git/index-helper.sock &&
#               test_config indexhelper.autorun true &&
#               git status &&
#               test -S .git/index-helper.sock &&
#               git status 2>err &&
#               test -S .git/index-helper.sock &&
#               test_must_be_empty err &&
#               git index-helper --kill &&
#               test_config indexhelper.autorun false &&
#               git status &&
#               test_path_is_missing .git/index-helper.sock
#
:

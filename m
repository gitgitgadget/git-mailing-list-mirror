From: Junio C Hamano <gitster@pobox.com>
Subject: Re: My custom cccmd
Date: Thu, 15 Oct 2009 13:09:08 -0700
Message-ID: <7vk4yw4dy3.fsf@alter.siamese.dyndns.org>
References: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 15 22:12:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyWgw-000552-GS
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 22:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935432AbZJOUJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 16:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935429AbZJOUJ6
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 16:09:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39824 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935427AbZJOUJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 16:09:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9183378854;
	Thu, 15 Oct 2009 16:09:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=abAoj/duLIw7hD1OUQqVZeDBAdU=; b=fihcWZ
	fME2V+wge9AG2eNmy/JH/5pKqTb9SFTaonSJy8vaxcddBCQBDEflxBwjEUK7WDq3
	UyOCyWmPKFF8zd0657rTerJ3gVy9yaaZbzlt9VL4tE1oHGRBl3ZjJ3ID5Z6NgXkG
	cgs9UPpcfJH6zd4O1Hwbod8Cxb3c2y7P00EPU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o18a3M5vI7YHxMCJQxVK48j6AkH2YyXd
	xwDsYmpYkt/ysGKx9nuoWzsZtTdv2HQz8bDTg85BQV+A80JYJWJoSdHIQQx75jiI
	NgvglpyLXSVCr3uVeTv7wiW1krRGT09ZwYHbtn/zSDGN4rKtFH77R0ZKQgr11vXZ
	X5RIwpsC4cE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7461578853;
	Thu, 15 Oct 2009 16:09:13 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4371178852; Thu, 15 Oct 2009
 16:09:09 -0400 (EDT)
In-Reply-To: <94a0d4530910150620g733bdf0aq88660053f869b0a9@mail.gmail.com>
 (Felipe Contreras's message of "Thu\, 15 Oct 2009 16\:20\:02 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9BAFCBF6-B9C6-11DE-AA3B-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130418>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Hi,
>
> I love the new option to run a cccmd and how good it works on the
> linux kernel, but I couldn't find a generic script. So I decided to
> write my own.
>
> It's very simple, it just looks into the authors of the commits that
> modified the lines being overridden (git blame). It's not checking for
> s-o-b, or anything fancy.
>
> Comments?

> #!/usr/bin/env ruby
>
> @commits = {} # keeps a count of commits per author
>
> ARGV.each do |filename|
>   File.open(filename) do |patch_file|
>     patch_file.each_line do |patch_line|
>       case patch_line
>       when /^---\s+(\S+)/
>         @source = $1[2..-1]
>       when /^@@\s-(\d+),(\d+)/
>         blame = `git blame -p -L #{$1},+#{$2} #{@source} | grep author`
>         blame.each_line do |al|
>           key, value = al.chomp.split(" ", 2)
>           case key
>           when "author"
>             @name = value
>           when "author-mail"
>             @mail = value
>             author = "\"#{@name}\" #{@mail}"
>             @commits[author] ||= 0
>             @commits[author] += 1
>           end
>         end
>       end
>     end
>   end
> end

Comments.

 #0. Gaahhh, my eyes, my eyes!!  Can't you do this ugly run of infinite
     number of "end"s?

 #1. You are not making sure that you start blaming from the commit the
     patch is based on, so your -La,b line numbers can be off.  If you can
     assume that you are always reading format-patch output, you can learn
     which commit to start from by reading the first "magic" line.
     
 #2. If you have two patch series that updates one file twice, some
     changes in your second patch could even be an update to the changes
     you introduced in your first patch.  After you fix issue #1, you
     would probably want to fix this by excluding the commits you have
     already sent the blames for.

 #3. Does the number of commits you keep per author have any significance?
     I know it doesn't in the implementation you posted, but should it,
     and if so how?

> @commits.each_key do |a|
>   puts a
> end
>
> -- 
> Felipe Contreras
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 1/3] make-static: master
Date: Wed, 14 Sep 2011 10:52:10 +0200
Message-ID: <201109141052.10257.trast@student.ethz.ch>
References: <4E6D0E3F.3090304@ramsay1.demon.co.uk> <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 10:52:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3lCc-0008Go-38
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 10:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754463Ab1INIwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 04:52:12 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:54580 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291Ab1INIwL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 04:52:11 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 14 Sep
 2011 10:52:09 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 14 Sep
 2011 10:52:10 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <7vhb4in4j7.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181347>

Junio C Hamano wrote:
> diff --git a/graph.h b/graph.h
[...]
> @@ -50,18 +33,6 @@ void graph_update(struct git_graph *graph, struct commit *commit);
>  int graph_is_commit_finished(struct git_graph const *graph);
>  
>  /*
> - * Output the next line for a graph.
> - * This formats the next graph line into the specified strbuf.  It is not
> - * terminated with a newline.
> - *
> - * Returns 1 if the line includes the current commit, and 0 otherwise.
> - * graph_next_line() will return 1 exactly once for each time
> - * graph_update() is called.
> - */
> -int graph_next_line(struct git_graph *graph, struct strbuf *sb);

Well, you removed that, but you still have

  /*
   * Determine if a graph has finished outputting lines for the current
   * commit.
   *
   * Returns 1 if graph_next_line() needs to be called again before
   * graph_update() should be called.  Returns 0 if no more lines are needed
   * for this commit.  If 0 is returned, graph_next_line() may still be
   * called without calling graph_update(), and it will merely output
   * appropriate "vertical padding" in the graph.
   */
  int graph_is_commit_finished(struct git_graph const *graph);

which pretty explicitly tells the user to call graph_next_line in
conjunction with graph_update, even though we currently don't have any
callers outside graph.c doing that.

(I can't really say whether the API would be better off without
graph_next_line exposed; I just noticed because I drag along the
line-log stuff and it uses graph_next_line.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
